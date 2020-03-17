library(rstan)
library(bayesplot)

rstan_options(auto_write=TRUE)
options(mc.cores = parallel::detectCores())

file_beer_sales_2 <- read.csv('../book-data/3-2-1-beer-sales-2.csv')
sample_size <- nrow(file_beer_sales_2)
sample_size

temperature_pred <- 11:30
temperature_pred

data_list_pred <- list(
  N = sample_size,
  sales = file_beer_sales_2$sales,
  temperature = file_beer_sales_2$temperature,
  N_pred = length(temperature_pred),
  temperature_pred = temperature_pred
)

data_list_pred


mcmc_result_pred <- stan(
  file = 'simple-lm-pred.stan',
  data = data_list_pred,
  seed = 1 
)

print(mcmc_result_pred)
