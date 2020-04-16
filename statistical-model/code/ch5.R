df = read.csv('../data/data3.csv')

fit1 <- glm(
  y ~ 1,
  data = df,
  family = poisson
)

fit2 <- glm(
  y ~ x,
  data = df, 
  family = poisson
)

fit1$deviance - fit2$deviance

df$y.rnd <- rpois(100, lambda = mean(df$y))

mean(df$y)
mean(df$y.rnd)

fit1 <- glm(
  y.rnd ~ 1,
  data = df,
  family = poisson
)
fit1

fit2 <- glm(
  y.rnd ~ x,
  data = df,
  family = poisson
)
fit2

fit1$deviance - fit2$deviance

source('pb.R')
dd12 <- pb(df, n.bootstrap=1000)

summary(dd12)
dd12

hist(dd12, 100)
abline(v = 4.5, lty = 2)

sum(dd12 >= 4.5)

quantile(dd12, 0.95)
sum(dd12 >= 3.8
    )

fit1 <- glm(
  y ~ 1,
  data = df,
  family = poisson
)
fit1

fit2 <- glm(
  y ~ x,
  data = df,
  family = poisson
)

anova(fit1, fit2, test='Chisq')
