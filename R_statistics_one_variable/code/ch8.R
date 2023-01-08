x <- seq(0,8, 0.1)
curve(dgamma(x, shape=3, scale=1), 0, 8)

x <- rexp(3*100000, rate=1)
xm <- matrix(x, nrow=100000, ncol=3)
s <- apply(xm, 1, sum)
hist(s, prob=TRUE)

x <- matrix(c(1, 5, 2, 7, 4, 9), nrow=3, ncol=2)
x
apply(x, 1, sum)
apply(x, 2, sum)
