df = read.csv('../data/data3.csv')

df

class(df)
summary(df)

plot(df$x, df$y, pch=c(21, 19)[df$f])

plot(df$f, df$y, pch=c(21, 19)[df$f])

fit <- glm(
  y ~ x,
  data = df,
  family = poisson
)
fit

summary(fit)
logLik(fit)

plot(df$x, df$y, pch=c(21, 19)[df$f])
xx <- seq(min(df$x), max(df$x), length=100)
lines(xx, exp(1.29 + 0.07566 * xx), lwd=2)

fit.f <- glm(
  y ~ f,
  data = df,
  family = poisson
)

fit.f

logLik(fit.f)

fit.all <- glm(
  y ~ x + f,
  data = df,
  family = poisson
)

fit.all
summary(fit.all)

fit.null <- glm(
  y ~ 1,
  data =df,
  family = poisson
)
fit.null

logLik(fit.null)
