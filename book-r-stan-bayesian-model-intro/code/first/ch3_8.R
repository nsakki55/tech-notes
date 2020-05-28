# パッケージの読み込み
library(rstan)
library(ggplot2)
library(brms)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

fish_num_climate <- read.csv("../book-data/3-8-1-fish-num-1.csv")
summary(fish_num_climate)

ggplot(data=fish_num_climate, mapping=aes(x = temperature, y = fish_num)) + geom_point(aes(color=weather))

# ポアソン回帰モデルを作る
glm_pois_brms <- brm(
  formula = fish_num ~ weather + temperature,  # modelの構造を指定
  family = poisson(),                          # ポアソン分布を使う
  data = fish_num_climate,                     # データ
  seed = 1,                                    # 乱数の種
  prior = c(set_prior("", class = "Intercept"))# 無情報事前分布にする
)

# MCMCの結果の確認
glm_pois_brms

eff <- marginal_effects(glm_pois_brms, effects='temperature:weather')
plot(eff, points=TRUE)

set.seed(1)
eff_pred <- marginal_effects(glm_pois_brms, method='predict', effect='temperature:weather' , probs=c(0.005, 0.995))
plot(eff_pred, points=TRUE)


