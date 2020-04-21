# パッケージの読み込み
library(rstan)
library(brms)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
source('fix_mac.R')
fix_Mac

# 分析対象のデータ
file_beer_sales_2 <- read.csv("data/3-2-1-beer-sales-2.csv")

simple_lm_brms <- brm(
  formula = sales ~ temperature,
  family = gaussian(link = 'identity'),
  data = file_beer_sales_2,
  seed = 1
)

as.mcmc(simple_lm_brms, combine_chains = TRUE)

plot(simple_lm_brms)

simple_lm_formula <- bf(sales ~ temperature)

simple_lm_brms2 <- brm(
  formula = simple_lm_formula,
  family = gaussian(),
  data = file_beer_sales_2,
  seed = 1,
  chains = 4,
  iter = 2000,
  warmup = 1000,
  thin = 1
)

plot(simple_lm_brms2)
prior_summary(simple_lm_brms2)

simple_lm_brms3 <- brm(
  formula = simple_lm_formula,
  family = gaussian(),
  data = file_beer_sales_2,
  prior = c(set_prior("", class='Intercept'),
            set_prior("", class='sigma')),
  seed = 1,
  chains = 4,
  iter = 2000,
  warmup = 1000,
  thin = 1
)

plot(simple_lm_brms3)
prior_summary(simple_lm_brms3)

stancode(simple_lm_brms3)

standata_brms <- make_standata(
  formula = sales ~ temperature,
  family =  gaussian(),
  data = file_beer_sales_2
)

standata_brms

simple_lm_brms_stan <- stan(
  file = 'brms-stan-code.stan',
  data = standata_brms,
  seed = 1
)

stanplot(simple_lm_brms,
         type = 'intervals',
         pars = c('Intercept', 'temperature'),
         prob = 0.8,
         prob_outer = 0.95)

stanplot(simple_lm_brms,
         type = 'parcoord_data',
         pars = c('Intercept', 'temperature')
         )

prior_summary(simple_lm_brms)

new_data <- data.frame(temperature=20)

fitted(simple_lm_brms, new_data)

mcmc_sample <- as.mcmc(simple_lm_brms, combine_chains = TRUE)
head(mcmc_sample)
# 推定されたパラメタ別に保存しておく
mcmc_b_Intercept   <- mcmc_sample[,"b_Intercept"]
mcmc_b_temperature <- mcmc_sample[,"b_temperature"]
mcmc_sigma         <- mcmc_sample[,"sigma"]

saigen_fitted <- mcmc_b_Intercept + 20 * mcmc_b_temperature
saigen_fitted

mean(saigen_fitted)

quantile(saigen_fitted, probs = c(0.025, 0.975))
fitted(simple_lm_brms, new_data)

eff <- marginal_effects(simple_lm_brms)
plot(eff, points=TRUE)

set.seed(1)
eff_pre <- marginal_effects(simple_lm_brms, method='predict')
plot(eff_pre, points=TRUE)
