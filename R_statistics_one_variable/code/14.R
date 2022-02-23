sugar <- c(10.2, 10.0, 9.9, 9.8, 10.1)
t.test(sugar, mu=10.5)
t.test(sugar, mu=10.1)
t.test(sugar, mu=10.0)

t.test(sugar, mu=10.5, alternative = "less")
t.test(sugar, mu=10.5, alternative = "greater")

before <- c(18, 12, 16, 15, 20)
after <- c(15, 13, 14, 11, 17)
before - after
t.test(before, after, paired = TRUE, alternative = "greater")


men <- c(79, 56, 91, 60, 51, 82)
women <- c(97, 66, 83, 75, 53)
mean(men)
mean(women)
t.test(men, women)

library(effsize)
set.seed(100)
x- rnorm(100, 50, 10) 
y- rnorm(100, 55, 15) 
cohen.d(x,y)
cohen.d(x,y, hedges.correction = TRUE)

