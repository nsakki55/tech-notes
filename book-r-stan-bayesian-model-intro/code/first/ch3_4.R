library(stan)
library(bayesplot)

rstan_options(auto_write=TRUE)
options(mc.cores = parallel::detectCores())

file_beer_sales_2 <- read.csv('../book-data/3-2-1-beer-sales-2.csv')
sample_size <- nrow(file_beer_sales_2)

formula_lm <- formula(sales ~ temperature)
X <- model.matrix(formula_lm, file_beer_sales_2)

head(X, n = 5)

N <- nrow(file_beer_sales_2)
K <- 2

Y <- file_beer_sales_2$sales
data_list_design <- list(
  N = N,
  K = K,
  Y = Y,
  X = X
)

mcmc_result_pred <- stan(
  file = 'lm-design-matrix.stan',
  data = data_list_design,
  seed = 1
)

print(mcmc_result_pred, probs = c(0.025, 0.5, 0.975))
