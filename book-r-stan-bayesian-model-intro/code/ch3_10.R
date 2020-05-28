library(rstan)
library(bayesplot)
library(brms)
# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

source('fix_mac.R')
fix_Mac

interaction_1 <- read.csv('data/3-10-1-interaction-1.csv')

interaction_1
summary(interaction_1)

model.matrix(sales ~ publicity * bargen, interaction_1)

interaction_brms_1 <- brm(
  formula = sales ~ publicity * bargen,
  family = gaussian(link = 'identity'),
  data = interaction_1,
  seed = 1,
  prior = c(set_prior('', class = 'Intercept'),
            set_prior('', class = 'sigma'))
)

interaction_brms_1
newdata_1 <- data.frame(
  publicity = rep(c("not", "to_implement"),2),
  bargen = rep(c("not", "to_implement"),each = 2)
)
newdata_1
# 予測
round(fitted(interaction_brms_1, newdata_1), 2)

eff_1 <- marginal_effects(interaction_brms_1, effects='publicity:bargen')
plot(eff_1, points=TRUE)

interaction_2 <- read.csv('data/3-10-2-interaction-2.csv')
interaction_2

interaction_brms_2 <- brm(
  formula = sales ~ publicity * temperature,
  family = gaussian(link = 'identity'),
  data = interaction_2,
  seed = 1,
  prior = c(set_prior('', class = 'Intercept'),
            set_prior('', class = 'sigma'))
)

interaction_brms_2


eff_2 <- marginal_effects(interaction_brms_2, effects='temperature:publicity')
plot(eff_2, points=TRUE)

interaction_3 <- read.csv('data/3-10-3-interaction-3.csv')
interaction_3

ggplot(data = interaction_3, aes(x = product, y = sales, color = factor(clerk))) +
  geom_point()

interaction_brms_3 <- brm(
  formula = sales ~ product * clerk,
  family = gaussian(link = 'identity'),
  data = interaction_3,
  seed = 1,
  prior = c(set_prior('', class = 'Intercept'),
            set_prior('', class = 'sigma'))
)

interaction_brms_3

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
