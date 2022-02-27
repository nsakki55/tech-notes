#5-1
MAX <- 1000
mesh <- 0.1
v <- 1
x <- seq(0, 10, by=mesh)
n <- length(x)
alpha <- beta <- numeric(MAX)
for(i in 1:MAX) {
  y <- 1 + 0.5*x + runif(n, min = -sqrt(3), max=sqrt(3))
  res <- lm(y ~ x)
  alpha[i] <- summary(res)$coefficients[1, 1]
  beta[i] <- summary(res)$coefficients[2, 1]
}
hist(alpha, ylim = c(0, 2.5), prob=TRUE)
sdev <- sqrt(1/MAX+mean(x)^2/sum((x-mean(x))^2))
curve(dnorm(x, 1, sdev), add=TRUE)

hist(beta, prob=TRUE)
sdev2 <- sqrt(1/sum((x-mean(x))^2))
curve(dnorm(x, 0.5, sdev2), add=TRUE)

# 5-2
MAX <- 1000
mesh <- 0.1
v <- 1
x <- seq(0, 10, by=mesh)
n <- length(x)
alpha <- beta <- numeric(MAX)
for(i in 1:MAX) {
  y <- 1 + 0.5*x + rgamma(n, shape = 3, scale=1/sqrt(3))-sqrt(3)
  res <- lm(y ~ x)
  alpha[i] <- summary(res)$coefficients[1, 1]
  beta[i] <- summary(res)$coefficients[2, 1]
}
hist(alpha, ylim = c(0, 2.5), prob=TRUE)
sdev <- sqrt(1/MAX+mean(x)^2/sum((x-mean(x))^2))
curve(dnorm(x, 1, sdev), add=TRUE)

hist(beta, prob=TRUE)
sdev2 <- sqrt(1/sum((x-mean(x))^2))
curve(dnorm(x, 0.5, sdev2), add=TRUE)
