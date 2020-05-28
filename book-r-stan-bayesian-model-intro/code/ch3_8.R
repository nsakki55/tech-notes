library(rstan)
library(bayesplot)
library(brms)
# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

source('fix_mac.R')
fix_Mac

fish_num_climate <- read.csv('data/3-8-1-fish-num-1.csv')
fish_num_climate

summary(fish_num_climate)

ggplot(data = fish_num_climate, mapping = aes(x = temperature, y = fish_num)) +
  geom_point(aes(color = weather))

glm_pois_brms <- brm(
  formula = fish_num ~ weather + temperature,
  family = poisson(),
  data = fish_num_climate,
  seed = 1,
  prior = c(set_prior('', class = 'Intercept'))  
)

glm_pois_brms

plot(glm_pois_brms)

eff <- marginal_effects(glm_pois_brms, effects = 'temperature:weather')
plot(eff, points=TRUE)

set.seed(1)
eff_pred <- marginal_effects(glm_pois_brms, 
                             method = 'predict',
                             effects = 'temperature:weather',
                             probs = c(0.005, 0.995))
plot(eff_pred, points=TRUE)

formula_pois <- formula(fish_num ~ weather + temperature)
design_mat <- model.matrix(formula_pois, fish_num_climate)
design_mat

data_list <- list(
  N = nrow(fish_num_climate),
  K = 2,
  Y = fish_num_climate$fish_num,
  X = design_mat
)

result_stan <- stan(
  file = 'glm-pois-design-matrix.stan',
  data = data_list,
  seed= 1
)

