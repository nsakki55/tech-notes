# パッケージの読み込み
library(rstan)
library(bayesplot)
library(ggfortify)
library(gridExtra)
library(parallel)

cluster <- makePSOCKcluster("localhost")    
parSapply(cluster, 1:5, sqrt)
stopCluster(cluster)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

set.seed(1)
wn <- rnorm(n=100, mean=0, sd=1)
cumsum(c(1, 3, 2))

rw <- cumsum(wn)

p_wn_1 <- autoplot(ts(wn), main = "ホワイトノイズ")
p_rw_1 <- autoplot(ts(rw), main = "ランダムウォーク")
grid.arrange(p_wn_1, p_rw_1)

wn_mat <- matrix(nrow=100, ncol=20)
rw_mat <- matrix(nrow=100, ncol=20)

set.seed(1)
for (i in 1:20){
  wn <- rnorm(n=100, mean=0, sd=1)
  wn_mat[, 1] <- wn
  rw_mat[, i] <- cumsum(wn)
}

p_wn_2 <- autoplot(ts(wn_mat), facets=F, main='white noise') + theme(legend.position = 'none')
p_rw_2 <- autoplot(ts(rw_mat), facets=F, main='random walk') + theme(legend.position = 'none')
grid.arrange(p_wn_2, p_rw_2)

# データの読み込み
sales_df <- read.csv("../book-data/5-2-1-sales-ts-1.csv")

# 日付をPOSIXct形式にする
sales_df$date <- as.POSIXct(sales_df$date)

# データの先頭行を表示
head(sales_df, n = 3)

# POSIXctの補足
POSIXct_time <- as.POSIXct("1970-01-01 00:00:05", tz="UTC")
as.numeric(POSIXct_time)


# ローカルレベルモデルの推定 -------------------------------------------------------------

# データの準備
data_list <- list(
  y = sales_df$sales, 
  T = nrow(sales_df)
)

# モデルの推定
local_level_stan <- stan(
  file = "local-level.stan",
  data = data_list,
  seed = 1
)

# 収束の確認
mcmc_rhat(rhat(local_level_stan))

state_name <- 'mu'


