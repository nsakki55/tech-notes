library(rstan)
library(brms)
library(bayesplot)
library(ggfortify)
library(gridExtra)

source('fix_mac.R')
fix_Mac

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# 状態空間モデルの図示をする関数の読み込み
source("plotSSM.R", encoding="utf-8")

sales_df_3 <- read.csv("data/5-5-1-sales-ts-3.csv")
sales_df_3$date <- as.POSIXct(sales_df_3$date)
head(sales_df_3, n = 3)

# 図示
autoplot(ts(sales_df_3[, -1]))

data_list <- list(
  y = sales_df_3$sales,
  T = nrow(sales_df_3)
)

local_level <- stan(
  file = 'local-level.stan',
  data = data_list,
  seed = 1
)

local_level

