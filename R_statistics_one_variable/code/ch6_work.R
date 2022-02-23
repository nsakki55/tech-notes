# 6-1
barplot(dpois(0:10, lambda=2.3), names=0:10, xlab="x")
barplot(dpois(0:10, lambda=1), names=0:10, xlab="x")
barplot(dpois(0:10, lambda=5), names=0:10, xlab="x")
barplot(dpois(0:10, lambda=10), names=0:10, xlab="x")

# 6-2
k <- 0:40
barplot(dnbinom(k, size=3, prob=0.2), names.arg=k)
barplot(dnbinom(k, size=5, prob=0.5), names.arg=k)
barplot(dnbinom(k, size=20, prob=0.9), names.arg=k)
