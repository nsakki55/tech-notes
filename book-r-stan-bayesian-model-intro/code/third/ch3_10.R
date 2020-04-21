# パッケージの読み込み
library(rstan)
library(brms)
library(makedummies)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

source('fix_mac.R')
fix_Mac

interaction_1 <- read.csv("data/3-10-1-interaction-1.csv")
head(interaction_1, n = 3)

interaction_1
summary(interaction_1)

ggplot(data = interaction_1, mapping=aes(x=publicity, y=sales)) +
  geom_point(aes(color=bargen))

interaction_brms_1 <- brm(
  formula = sales ~ publicity + bargen + publicity:bargen,
  family = gaussian(),
  data = interaction_1,
  prior = c(set_prior('', class='Intercept'),
            set_prior('', class='sigma')),
  seed = 1
)

interaction_brms_1

plot(interaction_brms_1)

eff <- marginal_effects(interaction_brms_1, effects='publicity:bargen')
plot(eff, points=TRUE)

interaction_2 <- read.csv("data/3-10-2-interaction-2.csv")
head(interaction_2, n = 3)

ggplot(data = interaction_2, mapping=aes(x=temperature, y=sales)) +
  geom_point(aes(color=publicity))

interaction_brms_2 <- brm(
  formula = sales ~ publicity*temperature,
  family = gaussian(link='identity'),
  data = interaction_2,
  prior = c(set_prior('', class='Intercept'),
            set_prior('', class='sigma')),
  seed = 1
)

plot(interaction_brms_2)

eff <- marginal_effects(interaction_brms_2, effects='temperature:publicity')
plot(eff, points=TRUE)

interaction_3 <- read.csv("data/3-10-3-interaction-3.csv")
head(interaction_3, n = 3)

ggplot(data = interaction_3, mapping=aes(x=product, y=sales)) +
  geom_point(aes(color=factor(clerk)))

interaction_brms_3 <- brm(
  formula = sales ~ product*clerk,
  family = gaussian(link='identity'),
  data = interaction_3,
  prior = c(set_prior('', class='Intercept'),
            set_prior('', class='sigma')),
  seed = 1
)


plot(interaction_brms_3)

# 1つのグラフに回帰直線をまとめて描画する
int_conditions <- list(
  clerk = setNames(1:9, paste("clerk=", 1:9, sep=""))
)
int_conditions

eff_3 <- marginal_effects(interaction_brms_3,
                          effects = "product:clerk",
                          int_conditions = int_conditions)
plot(eff_3, points = TRUE)

conditions <- data.frame(clerk = 1:9)
conditions

eff_4 <- marginal_effects(interaction_brms_3,
                          effects = "product",
                          conditions = conditions)
plot(eff_4, points = FALSE)
