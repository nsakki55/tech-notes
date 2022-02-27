pi <- 3.141592
x <- seq(0, 2*pi, length=100)
y <- 1 + 2*sin(x) + 3*cos(2*x) + rnorm(length(x), 0, 0.2)
plot(x, y)
res_sin <- lm(y ~ I(sin(x)) + I(cos(2*x)))
lines(x, fitted(res_sin))
summary(res_sin)
curve(1/(1+exp(-x)), -10, 10, ylab="y")


data <- read.csv('data/Population_UTF-8.csv')
head(data)
city <- data$人口総数
city <- city[!is.na(city)]
ord <- order(city, decreasing = TRUE)
city_popl <- city[ord]
rank <- 1:21
plot(rank, city_popl)
plot(log(rank), log(city_popl))
result <- lm(log(city_popl) ~ log(rank))
summary(result)
abline(result)
