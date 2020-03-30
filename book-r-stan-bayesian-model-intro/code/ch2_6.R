file_beer_sales_ab <- read.csv('data/2-6-1-beer-sales-ab.csv')
head(file_beer_sales_ab)

ggplot(data=file_beer_sales_ab, mapping = aes(x=sales, y=..density.., color=beer_name, fill=beer_name)) + 
  geom_histogram(alpha=0.5, position='identity') +
  geom_density(alpha=0.5, size=0)

sales_a <- file_beer_sales_ab[file_beer_sales_ab$beer_name=='A',]$sales
sales_b <- file_beer_sales_ab[file_beer_sales_ab$beer_name=='B',]$sales

data_list <- list(
  sales_a = sales_a,
  sales_b = sales_b,
  N = 100
)

mcmc_result <- stan(
  file = 'difference-mean.stan',
  data = data_list,
  seed = 1
)

mcmc_result

mcmc_sample <- rstan::extract(mcmc_result, permuted=FALSE)
mcmc_dens(mcmc_sample, pars='diff')
