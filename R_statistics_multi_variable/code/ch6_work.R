# 6-1
data <- read.csv('data/population2_UTF-8.csv', header = FALSE)
head(data$V2)
data$X1395.38
city <- data$V2
city <- city[!is.na(city)]
ord <- order(city, decreasing = TRUE)
city_popl <- city[ord]
rank <- 1:length(city)
plot(rank, city_popl)
plot(log(rank), log(city_popl))
result <- lm(log(city_popl) ~ log(rank))
summary(result)
abline(result)

# 6-2
f <- function(x) return (x^3 - 3*x)
x <- seq(-2, 2, by=0.1)
y <- f(x) + rnorm(length(x), 0, sd=0.2)
plot(x, y)
curve(f, add=TRUE)
res <- lm(y ~x+I(x^2) + I(x^3))
print(summary(res))
