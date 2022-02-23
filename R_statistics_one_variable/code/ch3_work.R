# 3-1
x1 <- rnorm(100, 100, 10)
y1 <- rnorm(100, 100, 10)
x2 <- rnorm(100, 150, 10)
y2 <- rnorm(100, 150, 10)
plot(x1, y1, xlim=c(70, 180), ylim=c(70, 180), xlab="", ylab="")
par(new=TRUE)
plot(x1, y1, xlim=c(70, 180), ylim=c(70, 180), xlab="", ylab="", pch=16)
x <- c(x1, x2)
y <- c(y1, y2)
cor(x, y)
cor(x2, y2)

