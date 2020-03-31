library(rstan)
library(bayesplot)
library(brms)
# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

source('fix_mac.R')
fix_Mac

fish_num_climate_2 <- read.csv('data/4-1-1-fish-num-2.csv')
fish_num_climate_2

fish_num_climate_2$id <- as.factor(fish_num_climate_2$id)
fish_num_climate_2

glm_pois_brms <- brm(
  formula = fish_num ~ weather + temperature,
  family = poisson(),
  data = fish_num_climate_2,
  seed= 1,
  prior = c(set_prior('', class = 'Intercept'))
)

glm_pois_brms

set.seed(1)
eff_glm_pred <- marginal_effects(
  glm_pois_brms,
  method = 'predict',
  effects = 'temperature:weather',
  probs = c(0.005, 0.995)
)

plot(eff_glm_pred, points=T)

formula_pois <- formula(fish_num ~ weather + temperature)
design_mat <- model.matrix(formula_pois, fish_num_climate_2)
design_mat
sunny_dummy <- as.numeric(design_mat[, 'weathersunny'])

data_list <- list(
  N = nrow(fish_num_climate_2),
  fish_num = fish_num_climate_2$fish_num,
  temp = fish_num_climate_2$temperature,
  sunny = sunny_dummy
)

data_list

glmm_pois_stan <- stan(
  file = 'glmm-pois.stan',
  data = data_list,
  seed = 1
)

glmm_pois_stan

mcmc_rhat(rhat(glmm_pois_stan))

glmm_pois_brms <- brm(
  formula = fish_num ~ weather + temperature + (1|id),
  family = poisson(),
  data = fish_num_climate_2,
  seed = 1,
  prior = c(set_prior('', class = 'Intercept'),
            set_prior('', class = 'sd'))
)

glmm_pois_brms
plot(glmm_pois_brms)

set.seed(1)
eff_glm_pred <- marginal_effects(
  glmm_pois_brms,
  method = 'predict',
  effects = 'temperature:weather',
  probs = c(0.005, 0.995)
)
plot(eff_glm_pred, points=T)
