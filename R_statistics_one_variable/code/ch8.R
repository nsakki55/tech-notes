x <- seq(0,8, 0.1)
curve(dgamma(x, shape=3, scale=1), 0, 8)

x <- rexp(3*100000, rate=1)
xm <- matrix(x, nrow=100000, ncol=3)
s <- apply(xm, 1, sum)
hist(s, prob=TRUE)
