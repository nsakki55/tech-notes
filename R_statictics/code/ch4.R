data <- read.csv('shidouhou.csv',header=T,fileEncoding="CP932")

set.seed(1)
dice6 <- ceiling(runif(n=6, min=0, max=6))
table(dice6)

dice6M <- ceiling(runif(n=6000000, min=0, max=6))
table(dice6M)

barplot(c(2/3, 1/3), names.arg=c('male', 'female'))

curve(dnorm(x, mean=0, sd=1), from=-4, to=4)
curve(dnorm(x, mean=1, sd=1), add=TRUE)
curve(dnorm(x, mean=0, sd=2), add=TRUE)

dnorm(1, mean=0, sd=1)
dnorm(3,mean=0, sd=1)

rnorm(n=5, mean=50, sd=10)
rnorm(n=5, mean=50, sd=10)

sample <- rnorm(n=5, mean=50, sd=10)
sample
hist(sample)

sample_big <- rnorm(n=10000, mean=50, sd=10)
hist(sample_big)

sample <- rnorm(n=10, mean=50, sd=10)
sample
mean(sample)
sd(sample)

sample <- rnorm(n=10, mean=50, sd=10)
sample
mean(sample)
sd(sample)

sample_mean <- numeric(length=10000)
sample_sd <- numeric(length=10000)
for(i in 1:10000){
  sample <- rnorm(n=10, mean=50, sd=10)
  sample_mean[i] <- mean(sample)
  sample_sd[i] <- sd(sample)
}
hist(sample_mean)
hist(sample_sd)

abs_under5 <- ifelse(abs(sample_mean - 50)<=5, 1, 0)
table(abs_under5)

mean(sample_mean)
var(sample_mean)

hist(sample_mean)
curve(dnorm(x, mean=50, sd=sqrt(10)), add=TRUE)

dnorm(50, mean=50, sd=sqrt(10))

hist(sample_mean, freq=FALSE)
curve(dnorm(x, mean=50, sd=sqrt(10)), add=TRUE)

sample_mean <- numeric(length=10000)
sample_sd <- numeric(length=10000)
for(i in 1:10000){
  sample <- rnorm(n=100, mean=50, sd=10)
  sample_mean[i] <- mean(sample)
  sample_sd[i] <- sd(sample)
}

var(sample_mean)
hist(sample_mean)

sample_var <- numeric(length=10000)
unbiased_var <- numeric(length=10000)
for(i in 1:10000){
  sample <- rnorm(n=10, mean=50, sd=10)
  sample_var[i] <- mean((sample - mean(sample))^2)
  unbiased_var[i] <- var(sample)
}
mean(sample_var)
mean(unbiased_var)

sd(sample_var)
sd(unbiased_var)

hist(sample_var, breaks=seq(0, 500, 10))
hist(unbiased_var, breaks=seq(0, 500, 10))

mean(sqrt(unbiased_var))

sample_mean <- numeric(length=10000)
sample_median <- numeric(length=10000)
for(i in 1:10000){
  sample <- rnorm(n=100, mean=50, sd=10)
  sample_mean[i] <- mean(sample)
  sample_median[i] <- median(sample)
}

mean(sample_mean)
mean(sample_median)

sd(sample_mean)
sd(sample_median)

hist(sample_mean)
hist(sample_median)

ceiling(1.5)
runif(n=10, min=0, max=6)
curve(dnorm(x, mean=0, sd=1), from=-1, to=1)

# 練習問題
sample_mean <- numeric(length=5000)
for(i in 1:5000){
  sample <- rnorm(n=20, mean=50, sd=10)
  sample_mean[i] <- mean(sample)
}
mean(sample_mean)
hist(sample_mean, freq = FALSE)
curve(dnorm(x, mean=50, sd=sqrt(10)), add=TRUE)


sample <- rnorm(n=1, mean=0, sd=1)
hist(sample)

sample <- rnorm(n=4, mean=0, sd=1)
hist(sample)

sample <- rnorm(n=9, mean=0, sd=1)
hist(sample)

sample <- rnorm(n=16, mean=0, sd=1)
hist(sample)

sample <- rnorm(n=25, mean=0, sd=1)
hist(sample)

