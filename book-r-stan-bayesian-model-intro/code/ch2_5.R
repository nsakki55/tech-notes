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

mcmc_sample <- rstan::extract(mcmc_result, permuted=FALSE)
dim(mcmc_sample)

mcmc_sample[, 'chain:1', 'mu']

length(mcmc_sample[,, 'mu'])

mu_mcmc_vec <- as.vector(mcmc_sample[, , 'mu'])
median(mu_mcmc_vec)
mean(mu_mcmc_vec)

quantile(mu_mcmc_vec, probs=c(0.025, 0.975))
print(mcmc_result)

library(ggfortify)
autoplot(ts(mcmc_sample[, , 'mu']),
         facets = TRUE,
         ylab = 'mu')

mu_df <- data.frame(
  mu_mcmc_sample = mu_mcmc_vec
)

mcmc_density <- ggplot(data=mu_df, mapping = aes(x=mu_mcmc_sample)) + geom_density(size=1.5) 

data_hist <- ggplot(data=file_beer_sales_1, mapping = aes(x=sales)) + geom_histogram()

library(gridExtra)
grid.arrange(mcmc_density, data_hist, ncol=2)
  
library(bayesplot)

mcmc_hist(mcmc_sample, pars=c('mu', 'sigma'))
mcmc_result

mcmc_trace(mcmc_sample, pars=c('mu', 'sigma'))
mcmc_combo(mcmc_sample, pars=c('mu', 'sigma'))

mcmc_intervals(
  mcmc_sample, pars=c('mu', 'sigma'),
  probs = 0.9,
  prob_outer = 0.95
)

mcmc_areas(
  mcmc_sample, pars=c('mu', 'sigma'),
  probs = 0.6,
  prob_outer = 0.99
)

mcmc_acf_bar(mcmc_sample, pars=c('mu', 'sigma'))

animal_num <- read.csv('data/2-5-1-animal-num.csv')
head(animal_num, 4)

hist(animal_num$animal_num)

data_list <- list(animal_num = animal_num$animal_num, N = nrow(animal_num))

mcmc_normal <- stan(
  file = 'normal-dist.stan',
  data = data_list,
  seed = 1
)

mcmc_poisson <- stan(
  file = 'poisson-dist.stan',
  data = data_list,
  seed = 1
)

mcmc_normal
mcmc_poisson

y_rep_normal <- rstan::extract(mcmc_normal)$pred
y_rep_poisson <- rstan::extract(mcmc_poisson)$pred

dim(y_rep_poisson)

y_rep_normal
y_rep_poisson


ppc_hist(y = animal_num$animal_num, yrep=y_rep_normal[1:5, ])
ppc_hist(y = animal_num$animal_num, yrep=y_rep_poisson[1:5, ])

