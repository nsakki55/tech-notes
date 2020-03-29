# パッケージの読み込み
library(rstan)
library(ggplot2)
library(brms)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

germination_dat <- read.csv("../book-data/3-9-1-germination.csv")
head(germination_dat, n=5)
summary(germination_dat)

ggplot(data=germination_dat, mapping=aes(x=nutrition, y=germination, color=solar)) + geom_point()

glm_binom_brms <- brm(
  germination | trials(size) ~ solar + nutrition, # modelの構造を指定
  family = binomial(),                         # 二項分布を使う
  data = germination_dat,                      # データ
  seed = 1,                                    # 乱数の種
  prior = c(set_prior("", class = "Intercept"))# 無情報事前分布にする
)


glm_binom_brms

# 説明変数を作る
newdata_1 <- data.frame(
  solar = c("shade", "sunshine", "sunshine"),
  nutrition = c(2,2,3),
  size = c(10,10,10)
)
newdata_1

linear_fit <- fitted(glm_binom_brms, newdata_1, scale='linear')[,1]
fit <- 1 / (1 + exp(-linear_fit))
fit

# オッズを計算
odds_1 <- fit[1] / (1 - fit[1])
odds_2 <- fit[2] / (1 - fit[2])
odds_3 <- fit[3] / (1 - fit[3])

coef <- fixef(glm_binom_brms)[,1]
coef
fixef(glm_binom_brms)

eff <- marginal_effects(glm_binom_brms, effects='nutrition:solar')
plot(eff, points=TRUE)

