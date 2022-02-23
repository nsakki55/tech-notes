x <- rweibull(10000, 8, 3)
library(MASS)
fitdistr(x, "weibull")
hist(x, prob=TRUE)
curve(dweibull(x, shape=8.020377483, scale=3.002200647), add=TRUE)

x <- rnorm(100000, 10, 5)
xm <- matrix(x, nrow=10000, ncol=10)
unbiased_var <- apply(xm, 1, var)
biased_var <- (9/10) * unbiased_var

hist(unbiased_var)
abline(v=25, lwd=2)
abline(v=mean(biased_var), lwd=2, lty="dashed")

mean(unbiased_var)
mean(biased_var)