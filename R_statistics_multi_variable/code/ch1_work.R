# 1-1
greenpea <- c(315, 101, 108, 32)
prob.theory <- c(9, 3, 3, 1) / 16
sum(greenpea)*prob.theory
chisq.test(greenpea, p=prob.theory)

# 1-2
theory <- c(0.38, 0.31, 0.22, 0.09)
people <- c(15, 9, 2, 1)
chisq.test(people, p=theory)
people2 <- c(15, 9, 2, 1) * 10
chisq.test(people2, p=theory)

# 1-4
death <- c(318, 245, 282, 270, 253, 235, 280, 296, 279, 338, 326, 410)
chisq.test(death, p=rep(1/12, length=12))

# 1-6
x1 <- rnorm(10000, 0, 1)
x2 <- rnorm(10000, 0, 1)
x3 <- rnorm(10000, 0, 1)
mu <- (x1+x2+x3) / 3
A <- (x1 - mu)^2 + (x2 - mu)^2 + (x3 - mu)^2
B <- x1^2 + x2^2 + x3^2
hist(A, ylim=c(0, 0.5), prob=TRUE)
curve(dchisq(x, df=2), add=TRUE)

hist(B, ylim=c(0, 0.3), prob=TRUE)
curve(dchisq(x, df=3), add=TRUE)
