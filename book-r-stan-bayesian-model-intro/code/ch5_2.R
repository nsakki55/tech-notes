library(rstan)
library(bayesplot)
library(brms)
library(ggfortify)
library(gridExtra)
# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

source('fix_mac.R')
fix_Mac

set.seed(1)
wn <- rnorm(n=100, mean=0, sd=1)
rw <- cumsum(wn)

p_wn_1 <- autoplot(ts(wn))
p_rw_1 <- autoplot(ts(rw))
grid.arrange(p_wn_1, p_rw_1)

wn_mat <- matrix(nrow = 100, ncol = 20)
rw_mat <- matrix(nrow = 100, ncol = 20)

set.seed(1)
for(i in 1:20){
  wn <- rnorm(n = 100, mean = 0, sd = 1)
  wn_mat[,i] <- wn
  rw_mat[,i] <- cumsum(wn)
}

# グラフを作る
p_wn_2 <- autoplot(ts(wn_mat), facets = F, main = "ホワイトノイズ") + 
  theme(legend.position = 'none') # 凡例を消す

p_rw_2 <- autoplot(ts(rw_mat), facets = F, main = "ランダムウォーク") + 
  theme(legend.position = 'none') # 凡例を消す

# 2つのグラフをまとめる
grid.arrange(p_wn_2, p_rw_2)

sales_df <- read.csv('data/5-2-1-sales-ts-1.csv')
sales_df$date <- as.POSIXct(sales_df$date)

data_list <- list(
  y = sales_df$sales,
  T = nrow(sales_df)
)

local_level_stan <- stan(
  file = 'local-level.stan',
  data = data_list,
  seed = 1
)

mcmc_rhat(rhat(local_level_stan))

mcmc_sample <- rstan::extract(local_level_stan)
local_level_stan

quantile(mcmc_sample[['mu']][, 1], probs = c(0.025, 0.5, 0.975))

state_name <- "mu"
result_df <- data.frame(t(apply(
  X = mcmc_sample[[state_name]],# 実行対象となるデータ
  MARGIN = 2,                   # 列を対象としてループ
  FUN = quantile,               # 実行対象となる関数
  probs=c(0.025, 0.5, 0.975)    # 上記関数に入れる引数
)))
colnames(result_df) <- c("lwr", "fit", "upr")

result_df$time <- sales_df$date

# 観測値の追加
result_df$obs <- sales_df$sales

# 図示のためのデータの確認
head(result_df, n = 3)

ggplot(data = result_df, aes(x = time, y = obs)) + 
  labs(title="ローカルレベルモデルの推定結果") +
  ylab("sales") + 
  geom_point(alpha = 0.6, size = 0.9) +
  geom_line(aes(y = fit), size = 1.2) +
  geom_ribbon(aes(ymin = lwr, ymax = upr), alpha = 0.3) + 
  scale_x_datetime(date_labels = "%Y年%m月")
