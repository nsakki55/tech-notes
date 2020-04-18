d <- read.csv('../data/data6a.csv')
summary(d)

plot(d$x, d$y, pch=c(21, 19)[df$f])

plot(d$f, d$y, pch=c(21, 19)[df$f])

logistic <- function(z)
{
  1 / (1 + exp(-z)) 
}

z <- seq(-6, 6, 0.1)
plot(z, logistic(z), type='l')

z_value <- function(x, beta1, beta2)
{
  beta1 + beta2*x
}

x <- seq(-6, 6, 0.1)

z <- z_value(x, 0, 2)
plot(x, logistic(z), type='l')
par(new=T)
z <- z_value(x, -3, 2)
plot(x, logistic(z), type='l')
par(new=T)
z <- z_value(x, 2, 2)
plot(x, logistic(z), type='l')

z <- z_value(x, 0, 4)
plot(x, logistic(z), type='l')
par(new=T)
z <- z_value(x, 0, -1)
plot(x, logistic(z), type='l')
par(new=T)
z <- z_value(x, 0, 2)
plot(x, logistic(z), type='l')

fit <- glm(
  cbind(y, N - y) ~ x + f,
  data = d,
  family = binomial
)

fit

z_value <- function(x, t, beta1, beta2, beta3)
{
  beta1 + beta2*x + beta3*t
}
x <- seq(8, 12, 0.1)
z <- z_value(x, 0, -19.536, 1.952, 2.022)
plot(x, logistic(z), type='l')
par(new=T)
plot(d$x, d$y, pch=c(21, 19)[df$f])
par(new=T)
z <- z_value(x, 1, -19.536, 1.952, 2.022)
plot(x, logistic(z), type='l')

library(MASS)
stepAIC(fit)

fit_2 <- glm(
  cbind(y, N - y) ~ x + f + x:f,
  data = d,
  family = binomial
)

fit_2

fit

d <- read.csv('../data/data6b.csv')

fit_area <- glm(
  y ~ x,
  offset = log(A),
  family = poisson,
   data = d
)
fit_area

y <- seq(-5, 5, 0.1)
plot(y, dnorm(y, mean=0, sd=1), type='l')

pnorm(1.8, 0, 1) -pnorm(1.2, 0, 1)

d <- read.csv('../data/data6c.csv')
plot(d$x, d$y)

fit <- glm(
  y ~ log(x),
  family = Gamma(link='log'),
  data = d
)
fit
 