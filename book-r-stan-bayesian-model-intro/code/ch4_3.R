# パッケージの読み込み
library(rstan)
library(bayesplot)
library(brms)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

fish_num_climate_4 <- read.csv("../book-data/4-3-1-fish-num-4.csv") 
head(fish_num_climate_4)
summary(fish_num_climate_4)

glmm_pois_brms_interaction <- brm(
  formula = fish_num ~ temperature * human,
  family = poisson(),
  data = fish_num_climate_4,
  seed = 1,
  prior = c(set_prior('', class='Intercept'))
)

conditions <- data.frame(
  human = c("A","B","C","D","E","F","G","H","I","J"))

eff_1 <- conditional_effects(
  glmm_pois_brms_interaction,
  effects = "temperature",
  conditions = conditions)
plot(eff_1, points=TRUE)

glmm_pois_brms_keisu <- brm(
  formula = fish_num ~ temperature + (temperature||human),
  family = poisson(),
  data = fish_num_climate_4,
  seed = 1,
  iter = 6000,
  warmup = 5000,
  control = list(adapt_delta = 0.97, max_treedepth = 15)
)

glmm_pois_brms_keisu

eff_2 <- conditional_effects(
  glmm_pois_brms_keisu,
  re_formula = NULL,
  effects = "temperature",
  conditions = conditions)
plot(eff_2, points=TRUE)