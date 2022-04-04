# 12-1
library(MASS)
library(car)
library(ellipse)
mu <- c(2, 1)
Sigma <- matrix(c(16, 2, 2, 9), 2, 2)
data2d <- mvrnorm(100, mu, Sigma)
dataEllipse(data2d, lebvel=0.8)

# 12-2
mp.max <- apply(mp.matrix, 1, max)
mean(mp.max); sd(mp.max)
