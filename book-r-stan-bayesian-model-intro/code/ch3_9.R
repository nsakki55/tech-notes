library(rstan)
library(bayesplot)
library(brms)
# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

source('fix_mac.R')
fix_Mac

germination_dat <- read.csv('data/3-9-1-germination.csv')

head(germination_dat)
summary(germination_dat)

ggplot(data = germination_dat, mapping = aes(x = nutrition, y = germination, color=solar)) +
  geom_point()

glm_binom_brms <- brm(
  germination | trials(size) ~ solar + nutrition,
  family = binomial(),
  data = germination_dat,
  seed = 1,
  prior = c(set_prior('', class = 'Intercept'))
)

glm_binom_brms

newdata_1 <- data.frame(
  solar = c("shade", "sunshine", "sunshine"),
  nutrition = c(2,2,3),
  size = c(10,10,10)
)
newdata_1

linear_fit <- fitted(glm_binom_brms, newdata_1, scale='linear')[,1]
fit <- 1 / (1 + exp(-linear_fit))
fit

coef <- fixef(glm_binom_brms)[, 1]
coef

eff <- conditional_effects(glm_binom_brms, effects='nutrition:solar')
plot(eff, points=TRUE)

