# パッケージの読み込み
library(rstan)
library(brms)
library(makedummies)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

source('fix_mac.R')
fix_Mac

# 分析対象のデータ
fish_num_climate <- read.csv("data/3-8-1-fish-num-1.csv")
head(fish_num_climate, 3)
fish_num_climate

ggplot(data=fish_num_climate, mapping=aes(x=temperature, y=fish_num)) +
  geom_point(aes(color=weather))

fish_num_climate

glm_poisson_grms <- brm(
  formula = fish_num ~ weather + temperature,
  family = poisson(),
  data = fish_num_climate,
  prior = c(set_prior('', 'Intercept')),
  seed = 1
)

glm_poisson_grms

eff <- marginal_effects(glm_poisson_grms, effects='temperature:weather')
plot(eff, points=TRUE)

set.seed(1)
eff_pre <- marginal_effects(glm_poisson_grms,
                            method='predict',
                            effects='temperature:weather',
                            probs=c(0.005, 0.995))

plot(eff_pre, points=TRUE)

formula_pois <- formula(fish_num ~ weather + temperature)
design_mat <- model.matrix(formula_pois, fish_num_climate)

design_mat

data_list = list(
  N = nrow(fish_num_climate),
  K = 3,
  Y = fish_num_climate$fish_num,
  X = design_mat
)
  
pois_stan <- stan(
  file = 'glm-pois-design.stan',
  data = data_list,
  seed = 1
)

fish_num_climate<- makedummies(fish_num_climate)

data_list <- list(
  N = nrow(fish_num_climate),
  fish_num = fish_num_climate$fish_num,
  temperature = fish_num_climate$temperature,
  sunny = fish_num_climate$weather
)

data_list

pois_stan_2 <- stan(
  file = 'glm-pois-1.stan',
  data = data_list,
  seed = 1
)

pois_stan_2

