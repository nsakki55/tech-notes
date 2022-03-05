data <- read.csv('data/11_1.csv')
x <- data$child
y <- data$parent

par(mfrow=c(2, 1))
hist(x)
hist(y)

mean(x)
median(x)
mean(y)
median(y)

varp <- function(x) {
  sample_var <- var(x) * (length(x) - 1) / length(x)
  sample_var
}

varp(x)
varp(y)

sqrt(varp(x))
sqrt(varp(y))

par(mfrow=c(1,x1))
dif <- y - x
dif
hist(dif)
mean(dif)
median(dif)
varp(dif)
sqrt(varp(dif))

cor(x, y)

lm_result <- lm(y ~ x)
summary(lm_result)
plot(x, y)
abline(lm_result)
