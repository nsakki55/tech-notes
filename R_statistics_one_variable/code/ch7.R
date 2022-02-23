curve(dnorm(x, mean=5, sd=1), 1, 9, type="l")
1 - pnorm(9, mean=8, sd=2)
plot(0:20, dbinom(0:20, 20, prob=0.5), xlab="", ylab="")
par(new=TRUE)
curve(dnorm(x, mean=10, sd=sqrt(20*0.5*(1-0.5))),0, 20, type="l", axes=FALSE)
curve(dlnorm(x, meanlog = 1, sdlog=1),0, 10, type="l")


curve(dexp(x, rate=2))
plot(c(0, 150), c(0,1), type="n", axes=FALSE, xlab="", ylab="")
axis(1)
n <- 50
r <- rexp(n, rate=0.5)
pos <- numeric(n)
for(i in 1:n) pos[i] <- sum(r[1:i])
segments(pos, 0.2, pos, 0.8)

x <- seq(-3.5, 0.1)
curve(dcauchy(x, location = 1, scale=2), -3,5)

x <- seq(0.5, 0.1)
curve(dweibull(x, shape=5, scale=3), 0, 5)
curve(dweibull(x, shape=1, scale=3), 0, 5)
curve(dweibull(x, shape=8, scale=3), 0, 5)

data <- read.csv('data/csv/Life Table.csv')
deathrate <- data$deathrate
age <- data$age + 1
plot(age, deathrate)
x <- age
y <- deathrate
res <- nls(y~(k/L)*(x/L)^(k-1)*exp(-(x/L)^k), start=c(k=9, L=80))
summary(res)
