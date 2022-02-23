x <- runif(100000)
y <- x^2
hist(y, prob=TRUE)
curve(1/(2*sqrt(x)), 0, 1, add=TRUE)
