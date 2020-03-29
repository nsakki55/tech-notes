library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

file_beer_sales_1 <- read.csv('data/2-4-1-beer-sales-1.csv')
file_beer_sales_1

data_list <- list(
  sales = file_beer_sales_1$sales,
  N = nrow(file_beer_sales_1)
)

data_list

mcmc_result <-rstan::stan(
  file = 'clacl_mean_variance.stan',
  data = data_list,
  seed = 1,
  chains = 4,
  iter = 2000,
  warmup = 1000,
  thin = 1
)

mcmc_result

library(rstan)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())


# データの読み込み ----------------------------------------------------------------

# 分析対象のデータ
file_beer_sales_1 <- read.csv("2-4-1-beer-sales-1.csv")

# データの確認
head(file_beer_sales_1, n = 3)


# Stanに渡すためにデータを整形する ------------------------------------------------------

# サンプルサイズ
sample_size <- nrow(file_beer_sales_1)
sample_size

# listにまとめる
data_list <- list(sales = file_beer_sales_1$sales, N = sample_size)
data_list


# MCMCによるサンプリングの実施 -----------------------------------------------------------------

# 乱数の生成
mcmc_result <- stan(
  file = "clacl_mean_variance.stan", # stanファイル
  data = data_list,                       # 対象データ
  seed = 1,                               # 乱数の種
  chains = 4,                             # チェーン数
  iter = 2000,                            # 乱数生成の繰り返し数
  warmup = 1000,                          # バーンイン期間
  thin = 1                                # 間引き数(1なら間引き無し) 
)

# 結果の表示
print(
  mcmc_result,                   # MCMCサンプリングの結果
  probs = c(0.025, 0.5, 0.975)   # 中央値と95%信用区間を出力
)

traceplot(mcmc_result)









