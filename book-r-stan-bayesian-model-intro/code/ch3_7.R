library(rstan)
library(bayesplot)
library(brms)
# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

source('fix_mac.R')
fix_Mac

sales_climate = read.csv('data/3-7-1-beer-sales-4.csv')

sales_climate
summary(sales_climate)

ggplot(data=sales_climate, mapping = aes(x = temperature, y = sales)) +
  geom_point(aes(color = weather))

lm_brms <- brm(
  formula = sales ~ weather + temperature,
  family = gaussian(),
  data = sales_climate,
  seed = 1,
  prior = c(set_prior('', class = 'Intercept'),
            set_prior('', class = 'sigma'))
)

lm_brms

eff <- marginal_effects(lm_brms, effects = 'temperature:weather')
plot(eff, points=TRUE)

formula_lm <- formula(sales ~ weather + temperature)
design_mat <- model.matrix(formula_lm, sales_climate)
design_mat

