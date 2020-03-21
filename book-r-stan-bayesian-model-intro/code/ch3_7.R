# パッケージの読み込み
library(rstan)
library(ggplot2)
library(brms)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

sales_climate <- read.csv("../book-data/3-7-1-beer-sales-4.csv")
summary(sales_climate)

ggplot(data=sales_climate, mapping=aes(x = temperature, y = sales)) + geom_point() + geom_point(aes(color=weather))

# 正規線形モデルを作る
lm_brms <- brm(
  formula = sales ~ weather + temperature,  # modelの構造を指定
  family = gaussian(),                      # 正規分布を使う
  data = sales_climate,                     # データ
  seed = 1,                                 # 乱数の種
  prior = c(set_prior("", class = "Intercept"),
            set_prior("", class = "sigma"))
)

