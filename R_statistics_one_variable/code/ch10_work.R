# 8-1
x <- rexp(1000*3, rate=5)
xm3 <- matrix(x, nrow=1000, ncol=3)
z3 <- apply(xm3, 1, mean)
hist(z3, xlim=c(0, 0.6), ylim=c(0, 5), prob=TRUE, ylab="")
par(new=TRUE)
plot(function(x)dnorm(x, mean=mean(z3), sd=sd(z3)), 
     xlim=c(0, 0.6), ylim=c(0, 5), lwd=2)

