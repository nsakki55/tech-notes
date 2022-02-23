# 1-1
5.63 / 171.58
5.56 / 158.23

# 1-2
data <- c(2, 5, 11, 7, 9)
mean(data)
prod(data) ^ (1 / length(data))
1 /mean(1/data)
var(data)
sqrt(var(data))
sd(data)

# 1-3
data <- c(34, 56, 32, 15, 49)
mu = mean(data)
sum(abs(data - mu)) / length(data)
sqrt(var(data) * (length(data) - 1) / length(data))

# 1-4
score <- c(65, 59, 62)
people <- c(500, 750, 690)
sum(score * people) / sum(people)

# 1-5
height <- c(171.8, 167.2, 180.9) 
weight <- c(74.4, 56.3, 93.2)
weight / (height * 0.01) ^2

# 1-6
data <- c(3, 4, 8, 11, 7)
sqrt(var(data))
sqrt(var(data) * (length(data) - 1) / length(data))

# 1-7
mu <- mean(math)
sigma <- sqrt(var(math) * (length(math) - 1) / length(math)) 
50 + 10 *((40 - mu) / sigma)
50 + 10 *((85 - mu) / sigma)

# 1-8
hist(rnorm(100, 50, 10))

# 1-9
boxplot(rnorm(100, 50, 5), rnorm(100, 10, 10))
IQR(rnorm(100, 50, 5))
IQR(rnorm(100, 10, 10))

# 1-10
x <- rnorm(5, 170, 10)
x
y <- c(500, x)
y
mean(y)
median(y)

# 1-11
sd(x)
sd(y)
mad(x)
mad(y)

# 1-12
mu <- mean(math)
sigma <- sqrt(var(math) * (length(math) - 1) / length(math)) 
Z <- (math - mu) / sigma 
mean(Z ** 3)
mean(Z ** 4 - 3)
