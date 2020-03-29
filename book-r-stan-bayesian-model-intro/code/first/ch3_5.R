# パッケージの読み込み
library(rstan)
library(brms)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# 分析対象のデータ
file_beer_sales_2 <- read.csv("../book-data/3-2-1-beer-sales-2.csv")


# brmsによる単回帰モデルの推定 -------------------------------------------------------------------

# 単回帰モデルを作る
simple_lm_brms <- brms::brm(
  formula = sales ~ temperature,         # modelの構造を指定
  family = gaussian(link = "identity"),  # 正規分布を使う
  data = file_beer_sales_2,              # データ
  seed = 1                               # 乱数の種
)
simple_lm_brms


#パッケージ
library(rstan)
library(brms)
library(bridgesampling)
library(tidyverse)
library(magrittr)

#パラメータの真値
alpha <- 2
beta <- c(3,4,0)

#乱数でデータ生成
set.seed(123)
x1=rnorm(100,0,1)
x2=rnorm(100,0,1)
x3 = rnorm(100,0,1)
y <- alpha + beta[1]*x1 + beta[2]*x2 + beta[3]*x3 + rnorm(100,0,10)
dat <- data.frame(y=y,x1=x1,x2=x2,x3=x3)
result0 <- brm(y ~ x1+x2+x3,data=dat,save_all_pars = TRUE,iter=10000)
result1 <- brm(y ~ x1+x2,data=dat,save_all_pars = TRUE,iter=10000)


# 複雑なformulaはbf関数で作成
simple_lm_formula <- brms::bf(sales ~ temperature)

# simple_lm_brmsと結果は同じ
simple_lm_brms_2 <- brm(
  formula = simple_lm_formula, # bf関数で作成済みのformulaを指定
  family = gaussian(),      # 正規分布を使う(リンク関数省略)
  data = file_beer_sales_2, # データ
  seed = 1,                 # 乱数の種
  chains = 4,               # チェーン数
  iter = 2000,              # 乱数生成の繰り返し数
  warmup = 1000,            # バーンイン期間
  thin = 1                  # 間引き数(1なら間引き無し) 
)

# 事前分布を無情報事前分布にする
simple_lm_brms_3 <- brm(
  formula = sales ~ temperature,
  family = gaussian(),
  data = file_beer_sales_2, 
  seed = 1,
  prior = c(set_prior("", class = "Intercept"),
            set_prior("", class = "sigma"))
)

# rstanに渡すデータを作る
standata_brms <- make_standata(
  formula = sales ~ temperature,
  family = gaussian(),
  data = file_beer_sales_2
)
standata_brms

simple_lm_brms_stan <- stan(
  file= 'brms-stan-code.stan',
  data = standata_brms,
  seed = 1ddd
)

simple_lm_brms_stan


