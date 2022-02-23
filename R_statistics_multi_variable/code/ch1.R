nankai <- c(0, 2, 0, 0, 0, 0, 0, 2, 1, 1, 1, 5)
month <- 1:12
barplot(nankai, names.arg=month, xlab="month", ylab="frequency")
chisq.test(nankai)
chisq.test(nankai, p=rep(1/12, length=12))

years <- c(1, 6, 6, 8, 5, 7, 0, 1, 0)
m <- sum((0:8)*years) / sum(years)
m
theory <- dpois(0:8, lambda = 3.058824)
theory

poisprob <- dpois(0:7, lambda = m)
theory <- c(poisprob, 1-sum(poisprob))
chisq.test(years, p=theory)

poisprob2 <- dpois(0:8, lambda = m)
theory2 <- c(poisprob2, 1-sum(poisprob2))
years2 <- c(years, 0)
chisq.test(years2, p=theory2)

rmultinom(5, size=10, prob=c(1, 2, 3)/6)

N <- 1000
p <- c(4, 3, 2, 1) / 10
x <- rmultinom(N, size=10, prob=p)
expmatrix <- rep(N*p, N)
z <- x - expmatrix
chisqval <- apply(z*z/expmatrix, 2, sum)
hist(chisqval)
