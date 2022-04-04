install.packages("mvtnorm")
install.packages("scatterplot3d")

library(mvtnorm)
library(scatterplot3d)
sigma.zero <- matrix(c(1, 0.5, 0.5, 1), ncol=2)
x <- seq(-3, 3, length=30)
y <- x
f <- function(x, y) {
  dmvnorm(matrix(c(x, y), ncol=2), mean=c(0, 0), sigma=sigma.zero)
}
z <- outer(x, y, f)
persp(x, y, z, theta=30, phi=30, expand=0.5, col="gray")

install.packages("ellipse")
install.packages("car")
library(car)
library(ellipse)
data <- read.csv('data/Math-Phys.csv')
head(data)
dataEllipse(data$math, data$phys, level = 0.8)

mp <- data.frame(data$math, data$phys) 
Sigma <- var(mp)
Sigma
eigen(Sigma)

sqrt(eigen(Sigma)$values)

cor.test(data$math, data$phys)
r <- 0.6191588
sqrt(146-2)*r/sqrt(1-r^2)

library(MASS)
mu <- c(2, 1)
Sigma <- matrix(c(16, 2, 2, 9), nrow=2, ncol=2)
mvrnorm(5 ,mu, Sigma)

N <- 100000
mp <- data.frame(data$math, data$phys)
Sigam <- var(mp)
mp.mu <- c(mean(data$math), mean(data$phys))
mp.rand <- mvrnorm(N, mp.mu, Sigma)
mp.matrix <- cbind(mp.rand[, 1], mp.rand[, 2])
mp.sum <- apply(mp.matrix, 1, sum)
hist(mp.sum, prob=TRUE)
curve(dnorm(x, mean=mean(mp.sum), sd=sd(mp.sum)), add=TRUE)


mu <- c(2, 1)
Sigma <- matrix(c(16, 0, 0, 9), nrow=2, ncol=2)
m <- 1000
n <- 20
r <- numeric(m)
for(i in 1:n){
  xydata <- mvrnorm(n, mu, Sigma)
  r[i] <- cor(xydata[, 1], xydata[, 2])
}
t0 <- sqrt(n-2)*r/sqrt(1-r^2)

mvrnorm(5 ,mu, Sigma)
hist(t0, xlim=c(-6, 6), ylim=c(0, 0.45), prob=TRUE, lwd=2)


