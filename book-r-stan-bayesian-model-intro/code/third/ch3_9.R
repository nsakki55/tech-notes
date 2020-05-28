# パッケージの読み込み
library(rstan)
library(brms)
library(makedummies)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

source('fix_mac.R')
fix_Mac

germination_dat <- read.csv("data/3-9-1-germination.csv")

germination_dat
summary(germination_dat)

ggplot(data=germination_dat, mapping=aes(x=nutrition, y=germination)) +
  geom_point(aes(color=solar))

glm_binom_brms <- brm(
  germination | trials(size) ~ solar + nutrition,
  family = binomial(),
  data = germination_dat,
  prior = c(set_prior('', class='Intercept')),
  seed = 1
)

glm_binom_brms

plot(glm_binom_brms)

eff <- marginal_effects(glm_binom_brms, effects='nutrition:solar')
plot(eff, points=TRUE)

germination_dummy <- makedummies(germination_dat)

data_list <- list(
  N = nrow(germination_dummy),
  germination = germination_dummy$germination,
  binom_size = germination_dummy$size,
  solar = germination_dummy$solar,
  nutrition = germination_dummy$nutrition
)

glm_binom_stan <- stan(
  file = 'glm-binom-1.stan',
  data = data_list,
  seed = 1
)

plot(glm_binom_stan)

mcmc_combo(glm_binom_stan)

