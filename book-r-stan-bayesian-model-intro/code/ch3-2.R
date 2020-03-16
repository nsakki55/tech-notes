library(rstan)
library(bayesplot)

rstan_options(auto_write=TRUE)
options(mc.cores = parallel::detectCores())

file_beer_sales_2 <- read.csv('../book-data/3-2-1-beer-sales-2.csv')
head(file_beer_sales_2, n=3)
sample_size <- nrow(file_beer_sales_2)
sample_size

ggplot(file_beer_sales_2, aes(x=temperature, y=sales)) + geom_point() + labs(titl='scatter plot')

mcmc_result <- stan(
  file = 'simple-lm.stan',
  data = data_list,
  seed = 1 
)

