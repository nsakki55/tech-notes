# ch2
rnorm(n=100, mean=50, sd=10)

curve(dnorm(x, mean=50, sd=10), 0, 100)

pnorm(60, mean=50, sd=10)

Z <- rnorm(n=100, mean=50, sd=10)
Z

hist(Z)
Z[1:10]

a <- c(5, 10, 100)
Z[a]
max(Z)
which.max(Z)
which.min(Z)
mean(Z)
summary(Z)

sample(1:10, 3)
sample(Z, 5)

coin <- c('Head', 'Tail')
sample(coin, 5, replace = TRUE)
mean(rnorm(100, 50, 10))

S <- 1000
rec <- numeric(S)
for(i in 1:S){rec[i] <- mean(rnorm(1000, 50, 10))}
rec
summary(rec)

S <- 1000
rec <- numeric(S)
for(i in 1:S){rec[i] <- mean(sample(1:6, 10, replace = TRUE))}
summary(rec)

x <- rnorm(1000, 50, 10)
var(x)
sd(x)


S <- 1000; n <- 1000
rec <- numeric(S)
for(i in 1:S){rec[i] <- sd(rnorm(n, 50, 10))}
rec
summary(rec)

x <- rnorm(100, 50, 10)
y <- rnorm(100, 50, 10)
plot(x, y)

z <- (x + y) / 2
plot(x, z)

cor(x, y)
cor(x, z)

cov(x, y)

# 練習問題
Z <-runif(100)
mean(Z)
var(Z)
sd(Z)


n <- 1000
rec <- numeric(n)
for(i in 1:n){rec[n] <- mean(runif(n))}
rec
summary(rec)
plot(c(1:1000), rec)

x <- runif(100)
y <- rnorm(100, 0, 1)
z <- 1.3*x - 0.7*y
plot(x, y)
cor(x, y)
plot(x, z)
cor(x, z)
plot(z, y)
cor(z, y)
