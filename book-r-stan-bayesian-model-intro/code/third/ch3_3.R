# パッケージの読み込み
library(rstan)
library(bayesplot)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

source('fix_mac.R')
fix_Mac

file_beer_sales_2 <- read.csv("data/3-2-1-beer-sales-2.csv")

# サンプルサイズ
sample_size <- nrow(file_beer_sales_2)

temperature_pred <- 11:30

data_list_pred <- list(
  N = sample_size,
  sales = file_beer_sales_2$sales, 
  temperature = file_beer_sales_2$temperature, 
  N_pred = length(temperature_pred),
  temperature_pred = temperature_pred
)

file_beer_sales_2

data_list
nrow(file_beer_sales_2)

mcmc_result_pred <- stan(
  file = 'simple-lm-pred.stan',
  data = data_list_pred,
  seed = 1
)

mcmc_result_pred

mcmc_sample_pred <- rstan::extract(mcmc_result_pred, permuted=FALSE)
mcmc_sample_pred

mcmc_intervals(
  mcmc_sample_pred, 
  regex_pars = c("sales_pred."), # 正規表現を用いてパラメタ名を指定
  prob = 0.8,        # 太い線の範囲
  prob_outer = 0.95  # 細い線の範囲
)


mcmc_intervals(
  mcmc_sample_pred, 
  pars = c("mu_pred[1]","sales_pred[1]"), # 正規表現を用いてパラメタ名を指定
  prob = 0.8,        # 太い線の範囲
  prob_outer = 0.95  # 細い線の範囲
)

mcmc_areas(
  mcmc_sample_pred,
  pars = c("sales_pred[1]","sales_pred[20]"),
  prob = 0.6,        # 太い線の範囲
  prob_outer = 0.99  # 細い線の範囲
)

