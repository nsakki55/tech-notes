library(rstan)
library(bayesplot)
library(brms)
# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

source('fix_mac.R')
fix_Mac

sales_weather <- read.csv('data/3-6-1-beer-sales-3.csv')
sales_weather

ggplot(data = sales_weather, mapping = aes(x=weather, y = sales)) + 
  geom_violin() +
  geom_point(aes(color=weather))

anova_brms <- brm(
  formula = sales ~ weather,
  family = gaussian(),
  data = sales_weather,
  seed = 1,
  prior = c(set_prior('', class='Intercept'),
            set_prior('', class='sigma'))
)

anova_brms

eff <- marginal_effects(anova_brms)
plot(eff, points=FALSE)

formula <- formula(sales ~ weather)
design_mat <- model.matrix(formula_anova, sales_weather)
