dbinom(7, 10, p=0.6)
dbinom(c(1, 5, 8), 10, p=0.6)
pbinom(3, 10, p=0.6)
sum(dbinom(0:3, 10, p=0.6))
round(sum(dbinom(0:3, 10, p=0.6)), 3)

barplot(dbinom(0:10, 10, 0.5), names=0:10, xlab="x")

barplot(dpois(0:10, lambda=2.3), names=0:10, xlab="x")

years <- c(1, 6, 6, 8, 5, 7, 0, 1, 0)
m <- sum((0:8) * years) / sum(years)
m

data <- data.frame(years, sum(years)*dpois(0:8, lambda=m))
barplot(t(data), col=c("black", "gray"), beside=TRUE, names.arg = 0:8, xlab="number")
legend("topleft", legend = c("real", "theory"), bg="transparent", fill=c("black", "gray"))

first <- rgeom(10000, prob=1/6)
hist(first, prob=TRUE)

k <- 0:40
barplot(dnbinom(k, size=3, prob=0.2), names.arg=k)
