# パッケージの読み込み
library(rstan)
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


## データの読み込みと図示

# データの読み込み
sales_df_4 <- read.csv("5-6-1-sales-ts-4.csv")
sales_df_4$date <- as.POSIXct(sales_df_4$date)
head(sales_df_4, n = 3)

# 図示
autoplot(ts(sales_df_4[, -1]))