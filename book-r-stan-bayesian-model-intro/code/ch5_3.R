library(rstan)
library(bayesplot)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

source('fix_mac.R')
fix_Mac

# 状態空間モデルの図示をする関数の読み込み
source("plotSSM.R", encoding="utf-8")

sales_df_all <- read.csv("data/5-2-1-sales-ts-1.csv")
sales_df_all$date <- as.POSIXct(sales_df_all$date)

data_list_pred <- list(
  T = nrow(sales_df_all),
  y = sales_df_all$sales, 
  pred_term  = 20
)

# モデルの推定
local_level_pred <- stan(
  file = "local-level-pred.stan",
  data = data_list_pred,
  seed = 1
)

local_level_pred
date_plot <- seq(
  from = as.POSIXct("2010-01-01"), 
  by = "days",
  len = 120)

mcmc_sample_pred <- rstan::extract(local_level_pred)

# 予測結果の図示
plotSSM(mcmc_sample = mcmc_sample_pred, 
        time_vec = date_plot, 
        state_name = "mu_pred", 
        graph_title = "予測の結果",
        y_label = "sales") 


# データの読み込み
sales_df_NA <- read.csv("data/5-3-1-sales-ts-1-NA.csv")

# 日付をPOSIXct形式にする
sales_df_NA$date <- as.POSIXct(sales_df_NA$date)
sales_df_omit_NA <- na.omit(sales_df_NA)
# データの準備
data_list_interpolation <- list(
  T       = nrow(sales_df_NA),
  len_obs = nrow(sales_df_omit_NA),
  y       = sales_df_omit_NA$sales, 
  obs_no  = which(!is.na(sales_df_NA$sales))
)

# モデルの推定
local_level_interpolation <- stan(
  file = "local-level-interpolation.stan",
  data = data_list_interpolation,
  seed = 1,
  iter = 4000
)

mcmc_sample_interpolation <- rstan::extract(
  local_level_interpolation)

# 図示
plotSSM(mcmc_sample = mcmc_sample_interpolation, 
        time_vec = sales_df_all$date, 
        obs_vec = sales_df_all$sales,
        state_name = "mu", 
        graph_title = "補間の結果",
        y_label = "sales") 

