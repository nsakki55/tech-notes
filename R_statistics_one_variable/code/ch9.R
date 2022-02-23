ave <- numeric(1000)
x <- as.integer(runif(1000, 1, 7))
for(n in 1:1000) ave[n] <- mean(x[1:n])
plot(1:1000, ave)
abline(h=3.5)

x <- runif(10000, -1, 1)
y <- runif(10000, -1, 1)
plot(x, y, col=ifelse(x^2+y^2<1, "black", "white"), pch=20, asp = 1)
4 * sum(x^2+y^2<1) / 100000
x1 <- 1:25
y1 <- numeric(25)
plot(x1, y1, pch=x1)

x <- runif(1000*50, min=0, max=12)
xm <- matrix(x, nrow=1000, ncol=50)
z50 <- apply(xm, 1, mean)
sum(abs(z50-6)>1)/1000
