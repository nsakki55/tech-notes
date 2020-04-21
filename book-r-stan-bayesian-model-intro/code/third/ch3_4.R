# パッケージの読み込み
library(rstan)
library(bayesplot)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# 分析対象のデータ
file_beer_sales_2 <- read.csv("data/3-2-1-beer-sales-2.csv")

formula_lm <- formula(sales ~ temperature)
X <- model.matrix(formula_lm, file_beer_sales_2)
X

N <- nrow(file_beer_sales_2)
K <- 2
Y = file_beer_sales_2$sales

data_list_design <- list(
  N = N,
  K = K,
  Y = Y,
  X = X
)

mcmc_result_design <- stan(
  file = 'lm-design-matrix.stan',
  data = data_list_design,
  seed = 1
)

mcmc_result_design

