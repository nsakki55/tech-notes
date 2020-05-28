# パッケージの読み込み
library(rstan)
library(brms)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

source('fix_mac.R')
fix_Mac
# データの読み込みと図示 -------------------------------------------------------------

# 分析対象のデータ
sales_climate <- read.csv("data/3-7-1-beer-sales-4.csv")
head(sales_climate, 3)

sales_climate

ggplot(data=sales_climate, mapping=aes(x=temperature, y=sales)) +
  geom_point(aes(color=weather))

lm_brms <- brm(
  formula = sales ~ weather + temperature,
  data = sales_climate,
  prior = c(set_prior('', 'Intercept'),
            set_prior('', 'sigma')),
  seed = 1
)

lm_brms

eff <- marginal_effects(lm_brms, effects = 'temperature:weather')
plot(eff, points=TRUE)
