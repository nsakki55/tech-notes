# パッケージの読み込み
library(rstan)
library(brms)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# データの読み込み -------------------------------------------------------------
source('fix_mac.R')
fix_Mac

# 分析対象のデータ
fish_num_climate_3 <- read.csv("data/4-2-1-fish-num-3.csv")
head(fish_num_climate_3, n = 3)

summary(fish_num_climate_3)

glmm_pois_brms_human <- brm(
  formula = fish_num ~ weather + temperature + (1|human),
  family = poisson(),
  data = fish_num_climate_3,
  prior = c(set_prior('', class = 'Intercept'),
            set_prior('', class='sd')),
  seed = 1
)

plot(glmm_pois_brms_human)
stanplot(glmm_pois_brms_human, type='rhat')

glmm_pois_brms_human

ranef(glmm_pois_brms_human)

conditions <- data.frame(
  human = c("A","B","C","D","E","F","G","H","I","J"))

eff_glmm_human <- marginal_effects(
  glmm_pois_brms_human,
  effects = "temperature:weather",
  re_formula = NULL,
  conditions = conditions)

plot(eff_glmm_human, points = TRUE)
