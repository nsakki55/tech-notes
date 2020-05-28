library(rstan)
library(bayesplot)
library(brms)
# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

source('fix_mac.R')
fix_Mac

fish_num_climate_3 <- read.csv('data/4-2-1-fish-num-3.csv')
fish_num_climate_3

glmm_pois_brms_human <- brm(
  formula = fish_num ~ weather + temperature + (1|human),
  family = poisson(),
  data = fish_num_climate_3,
  seed = 1,
  prior = c(set_prior('', class = 'Intercept'),
            set_prior('', class = 'sd'))
)

plot(glmm_pois_brms_human)
stanplot(glmm_pois_brms_human, type='rhat')

ranef(glmm_pois_brms_human)


# 調査者ごとにグラフを分けて、回帰曲線を描く
conditions <- data.frame(
  human = c("A","B","C","D","E","F","G","H","I","J"))

eff_glmm_human <- marginal_effects(
  glmm_pois_brms_human,
  effects = "temperature:weather",
  re_formula = NULL,
  conditions = conditions)

plot(eff_glmm_human, points = TRUE)

