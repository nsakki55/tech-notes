# 2-1
x <- seq(0, 1, by=0.01)
y <- 1 - x ^ 4
plot(x, y)
cor(x, y)
cor(x, y, method="spearman")
cor(x, y, method="kendall")

# 2-2
c1 <- 100
c2 <- 200
cor(x, y)
cor(x, y, method="spearman")
cor(x, y, method="kendall")
cor(c1*x, c2*y)
cor(c1*x, c2*y, method="spearman")
cor(c1*x, c2*y, method="kendall")

# 2-6
x <- seq(-1, 1, by=0.01)
y <- x^3 - 3*x + rnorm(length(x), 0, 0.01)
plot(x, y)
cor(x, y)

# 2-7
M <- 20
N <- 1000
d <- numeric(N)
for(i in 1:N) {
  x <- runif(M)
  y <- runif(M)
  tau <- cor(x, y, method='kendall')
  rho <- cor(x, y, method='spearman')
  d[i] <- 3*tau-2*rho
}
plot(d, ylim=c(-1.5, 1.5))
abline(h=-1)
abline(h=1)
