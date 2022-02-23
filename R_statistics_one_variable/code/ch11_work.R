library(MASS)
# 11-1
x <- rnorm(10000, 10, 5)
fitdistr(x, "normal")

x <- rpois(10000, 2)
fitdistr(x, "Poisson")

x <- rcauchy(10000, location=1, scale=10)
fitdistr(x, "cauchy")
