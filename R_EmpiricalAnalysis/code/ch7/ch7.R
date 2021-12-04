head(ToothGrowth)
len <- ToothGrowth$len
dose <- ToothGrowth$dose
supp <- ToothGrowth$supp
summary(lm(len ~ dose, subset = (supp=='VC')))
summary(lm(len ~ dose, subset = (supp=='OJ')))

n <- 200
e <- rnorm(n)
X <- (1 +0.5*e)*runif(n)
b0 <- 1
b1 <- 2
Y <- b0 + X*b1 + e
lm(Y ~ X)

