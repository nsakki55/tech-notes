plot(cars)
res <- lm(formula=dist~speed, data=cars)
res
plot(cars)
abline(res)
summary(res)

result <- lm(formula=dist~speed-1, data=cars)
summary(result)
plot(cars, xlim=c(0, 25))
abline(result)

x <- seq(0, 1, by=0.1)
y <- 100 - x
plot(x, y)
result <- lm(formula = y ~ x-1)
abline(result)
summary(result)

data <- read.csv('data/TIMSS2011.csv', header=T, fileEncoding = "SJIS",)
head(data)
likemath <- data$LikeMath.A.B.
scoremath <- data$Average.Score
plot(likemath, scoremath)
res<- lm(formula=scoremath ~ likemath)
abline(res)
summary(res)

res2 <- lm(likemath ~ scoremath)
plot(scoremath, likemath)
abline(res2)
summary(res2)

x <- 1:20
y <- x + rnorm(length(x),0,1)
plot(x, y)
res <- lm(y~x)
abline(res)
summary(res)

y[c(1, 5)] <- c(20, 18)
plot(x, y)
res_outlier <- lm(y~x)
abline(res_outlier)
summary(res_outlier)
