# 5-1
x <- runif(1000000)
y <- sqrt(x)
hist(y, prob=TRUE)
curve(2*x, 0, 1, add=TRUE)

# 5-2
x <- runif(1000000)
y <- -log(1-x)
hist(y, prob=TRUE)
curve(exp(-x), 0, 10, add=TRUE)

# 5-3
x <- runif(1000000, min=-pi/2, max=pi/2)
y <- sin(x)
hist(y, prob=TRUE)
curve(1/sqrt(1-x^2)/pi, -1, 1, add=TRUE)

