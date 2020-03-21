# パッケージの読み込み
library(rstan)
library(ggplot2)
library(brms)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

sales_weather <- read.csv("../book-data/3-6-1-beer-sales-3.csv")
head(sales_weather, n=5)

summary(sales_weather)
ggplot(data=sales_weather, mapping=aes(x = weather, y = sales)) + geom_violin() + geom_point(aes(color=weather))

# 分散分析モデルを作る
anova_brms <- brm(
  formula = sales ~ weather,  # modelの構造を指定
  family = gaussian(),        # 正規分布を使う
  data = sales_weather,       # データ
  seed = 1,                   # 乱数の種
  prior = c(set_prior("", class = "Intercept"),
            set_prior("", class = "sigma"))
)

# デザイン行列の作成
formula_anova <- formula(sales ~ weather)
design_mat <- model.matrix(formula_anova, sales_weather)

# stanに渡すlistの作成
data_list <- list(
  N = nrow(sales_weather), # サンプルサイズ
  K = 3,                   # デザイン行列の列数
  Y = sales_weather$sales, # 応答変数
  X = design_mat           # デザイン行列
)
# Stanに渡すデータの表示
data_list

anova_stan <- stan(
  file = 'lm-design-matrix.stan',
  data = data_list,
  seed = 1
)

anova_stan

