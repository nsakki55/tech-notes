library(rstan)
library(bayesplot)
# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

file_beer_sales_2 <- read.csv('data/3-2-1-beer-sales-2.csv')

file_beer_sales_2

ggplot(data=file_beer_sales_2, mapping=aes(x=temperature, y=sales)) +
  geom_point()

ggplot(data=file_beer_sales_2, mapping=aes(x=temperature)) +
  geom_histogram()

ggplot(data=file_beer_sales_2, mapping=aes(x=sales)) +
  geom_histogram()

data_list <- list(
  N = nrow(file_beer_sales_2),
  sales = file_beer_sales_2$sales,
  temperature = file_beer_sales_2$temperature
)

mcmc_result <- stan(
  file = 'simple-lm.stan',
  data = data_list,
  seed = 1
)

print(mcmc_result)

mcmc_sample <- rstan::extract(mcmc_result, permuted=FALSE)

mcmc_combo(
  mcmc_sample,
  pars = c('Intercept', 'beta', 'sigma')
)

mcmc_areas(mcmc_sample,
           pars = c('Intercept', 'beta', 'sigma'),
           prob = 0.8)


y_pred <- rstan::extract(mcmc_result)$pred
y_pred

dim(y_pred)
ppc_hist(y = file_beer_sales_2$sales, yrep=y_pred[1:5,])
