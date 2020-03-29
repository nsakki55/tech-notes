# パッケージの読み込み
library(rstan)
library(ggplot2)
library(brms)

# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

interaction_1 <- read.csv("../book-data/3-10-1-interaction-1.csv")
head(interaction_1, n=5)
summary(interaction_1)

interaction_brms <- brms::brm(
  formula = sales ~ publicity * bargen,
  family = gaussian(link='identity'),
  data = interaction_1,
  seed = 1,
  prior = c(set_prior('', class='Intercept'),
            set_prior('', class='sigma'))
)


# 分析対象のデータ
interaction_2 <- read.csv("../book-data/3-10-2-interaction-2.csv")
head(interaction_2, n = 3)
summary(interaction_2)

interaction_brms_2 <- brm(
  formula = sales ~ publicity * temperature,
  family = gaussian(link = "identity"),
  data = interaction_2,
  seed = 1,
  prior = c(set_prior("", class = "Intercept"),
            set_prior("", class = "sigma"))
)

interaction_brms_2

interaction_3 <- read.csv("../book-data/3-10-3-interaction-3.csv")
head(interaction_3, n = 3)

ggplot(data=interaction_3, mapping=aes(x=product, y=sales, color=factor(clerk))) + geom_point()

interaction_brms_3 <- brm(
  formula = sales ~ product * clerk,
  family = gaussian(link = "identity"),
  data = interaction_3,
  seed = 1,
  prior = c(set_prior("", class = "Intercept"),
            set_prior("", class = "sigma"))
)

int_conditions <- list(
  clerk = setNames(1:9, paste('clerk=', 1:9, sep=''))
)

int_conditions
