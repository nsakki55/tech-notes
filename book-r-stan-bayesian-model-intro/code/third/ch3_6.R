library(rstan)
library(brms)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

source('fix_mac.R')
fix_Mac
# データの読み込みと図示 -------------------------------------------------------------

# 分析対象のデータ
sales_weather <- read.csv("data/3-6-1-beer-sales-3.csv")
head(sales_weather, 3)

sales_weather

ggplot(data = sales_weather, mapping = aes(x=weather, y= sales)) +
  geom_violin() + geom_point(aes(color=weather))

anova_brms <- brm(
  formula = sales ~ weather,
  family = gaussian(link='identity'),
  data = sales_weather,
  seed = 1,
  prior = c(set_prior("", class='Intercept'),
            set_prior("", class='sigma'))
)

anova_brms

eff <- marginal_effects(anova_brms, method='predict')
plot(eff, points=FALSE)

design_mat <- model.matrix(formula(sales ~ weather), sales_weather)
design_mat

data_list <- list(
  N = nrow(sales_weather),
  K = 3,
  Y = sales_weather$sales,
  X = design_mat
)

anoba_stan_brms <- stan(
  file = 'lm-design-matrix.stan',
  data = data_list,
  seed = 1
)

anoba_stan_brms

plot(anoba_stan_brms)
