data <- read.csv('/Users/satsuki/Documents/tech-notes/R_EmpiricalAnalysis/author_code/R_EmpiricalAnalysis/02 演習用データ集/data_5_1.csv')
head(data)
mean(data$distA)
var(data$distA)
mean(data$distB)
var(data$distB)

hist(data$distA)
hist(data$distB)

t <- sqrt(100)*(mean(data$distA)) / sqrt(var(data$distA))
t
t <- sqrt(100)*(mean(data$distB)) / sqrt(var(data$distB))
t

t
1 -pnorm(t) + pnorm(-t)

x <- rnorm(1000, 0 ,1 )
y <- 1 + 5 * x + rnorm(1000, 0, 1)
beta1 <- lm(y~x)$coefficients[2]
beta1
names(lm(y~x))

S <- 10000
beta1 <- numeric(S)
for(i in 1:S){
  x <- rnorm(1000, 0, 1)
  y <- 1 + 5 * x + rnorm(1000, 0, 1)
  beta1[i] <- lm(y~x)$coefficients[2]
}
summary(beta1)
sd(beta1)
hist(beta1)


data <- read.csv('/Users/satsuki/Documents/tech-notes/R_EmpiricalAnalysis/author_code/R_EmpiricalAnalysis/02 演習用データ集/data_Males.csv')
head(data)
result <- lm(data$wage ~ data$school + data$exper)
summary(lm(data$wage ~ data$school + data$exper))
summary(result)$coefficients
summary(result)$coefficients[, 1:2]
betahat <- summary(result)$coefficients[, 1]
sigma <- summary(result)$coefficients[, 2]
cbind(betahat - 1.96*sigma, betahat+1.96*sigma)

lower <- betahat - 1.96*sigma
upper <- betahat + 1.96*sigma
CI <- data.frame(lower.bound=lower, upper.bound=upper)
CI


# 練習問題
## 5.1
data2 <- read.csv('/Users/satsuki/Documents/tech-notes/R_EmpiricalAnalysis/author_code/R_EmpiricalAnalysis/02 演習用データ集/data_3_2.csv',colClasses = "character", header = T)
data2$icecream <- as.numeric(data2$icecream)
data2$income <- as.numeric(data2$income)
data2$u15 <- as.numeric(data2$u15)
head(data2)
res <- lm(data2$icecream ~ data2$income + data2$u15)
summary(res)
summary(res)$coefficients[, 1:2]
betahat <- summary(res)$coefficients[, 1]
sigma <- summary(res)$coefficients[, 2]
lower <- betahat - 1.96*sigma
upper <- betahat + 1.96*sigma
CI <- data.frame(lower.bound=lower, upper.bound=upper)
CI

## 5.2
data3 <- read.csv('/Users/satsuki/Documents/tech-notes/R_EmpiricalAnalysis/author_code/R_EmpiricalAnalysis/02 演習用データ集/data_4_1.csv')
head(data3)
res <- lm(data3$temp ~ data3$time+data3$elec+data3$prec)
summary(res)
betahat <- summary(res)$coefficients[, 1]
sigma <- summary(res)$coefficients[, 2]
lower <- betahat - 1.96*sigma
upper <- betahat + 1.96*sigma
CI <- data.frame(lower.bound=lower, upper.bound=upper)
CI


## 5.3
S <- 10000
counts <- numeric(S)
for(i in 1:S){
  x <- rnorm(1000, 0, 1)
  y <- 1 + 5 * x + rnorm(1000, 0, 1)
  res <- lm(y~x)
  betahat <- summary(res)$coefficients[2, 1]
  sigma <- summary(res)$coefficients[2, 2]
  counts[i] <- (betahat - 1.96*sigma < 5) & (5 < betahat + 1.96*sigma)
}
mean(counts)
