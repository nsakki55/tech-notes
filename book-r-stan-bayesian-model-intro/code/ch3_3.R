library(rstan)
library(bayesplot)
# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

file_beer_sales_2 <- read.csv('data/3-2-1-beer-sales-2.csv')

temperature_pred <- 11:30

data_list <- list(
  N = nrow(file_beer_sales_2),
  sales = file_beer_sales_2$sales,
  temperature = file_beer_sales_2$temperature,
  
  N_pred = length(temperature_pred),
  temperature_pred = temperature_pred
)

mcmc_result_pred <- stan(
  file = 'simple-lm-pred.stan',
  data = data_list,
  seed = 1
)

print(mcmc_result_pred)

mcmc_sample_pred <- rstan::extract(mcmc_result_pred, permuted=FALSE)

mcmc_intervals(
  mcmc_sample_pred,
  regex_pred = c("sales_pred."),
  prob = 0.8,
  prob_outer = 0.95
)


mcmc_intervals(
  mcmc_sample_pred,
  pars = c("mu_pred[2]","sales_pred[1]"),
  prob = 0.8,
  prob_outer = 0.95
)

dimnames(mcmc_sample_pred)

mcmc_areas(
  mcmc_sample_pred,
  pars = c("sales_pred[1]","sales_pred[10]"),
  prob = 0.8,
  prob_outer = 0.99
)  
