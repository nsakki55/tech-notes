coin <- c(1, 0)
z <- sample(coin, 100, replace=TRUE)
sum(z)

S <- 10000
rec <- numeric(S)
for(i in 1:S){
  z <- sample(coin, 100, replace=TRUE)
  rec[i] <- sum(z)
}
hist(rec)
summary(rec)

count <- (rec==50)
mean(count)

S <- 10000
X <- rnorm(S, 50, 10)
Y <- rnorm(S, 50, 10)
Z <- X+Y
mean((X>70))*mean((Z>100))

mean((X>70)*(Z>100))

cor(X, Y)

Z <- -(X-50)^2/10
plot(X, Z)
cor(X, Z)

curve(pnorm(x, 50, 10), 0, 100)


pnorm(50+0.1, 50, 10) - pnorm(50, 50, 10)

X <- read.csv('/Users/satsuki/Documents/tech-notes/R_EmpiricalAnalysis/author_code/R_EmpiricalAnalysis/02 演習用データ集/data_Males.csv')
head(X)
summary(X)
plot(X)

sch11 <- X[X$school==11, ]
sch12 <- X[X$school==12, ]
sch16 <- X[X$school==16, ]
sch12
mean(sch12$wage)
exp(mean(sch11$wage))
exp(mean(sch12$wage))
exp(mean(sch16$wage))
sch16


S <- 10000
n <- 10000
Zn <- numeric(S)
for(i in 1:S){
  X <- rnorm(n,50,10)	
  Xbar <- mean(X)
  Sn <- var(X)
  Zn[i] <- sqrt(n)*(Xbar-50)/sqrt(Sn)
}
hist(Zn)

S <- 10000
n <- 10000
Zn <- numeric(S)
for(i in 1:S){
  X <- rnorm(n,50,10)	
  Xbar <- mean(X); Sn <- var(X)
  rec[i] <- (Xbar-1.96*sqrt(Sn/n)<50) *(50<Xbar+1.96*sqrt(Sn/n))
}
mean(rec)

