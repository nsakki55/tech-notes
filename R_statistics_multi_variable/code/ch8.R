library(DAAG)
res_VG <- lm(log(Volume) ~ log(Girth), data=trees)
vif(res_VGH)
summary(res_VGH)

res_check <- lm(log(Girth) ~ log(Height), data=trees)
summary(res_check)

1 / (1- summary(res_check)$r.squared)

x1 <- rnorm(100, 100, 1)
x2 <- rnorm(100, 50, 1)
x3 <- x1 + x2 + rnorm(100, 0, 0.0001)
z <- 5*x1 + 10*x2 + 20*x3 + rnorm(100, 0, 0.1)
res_test <- lm(z ~ x1 + x2 + x3)
summary(res_test)

res_test <- lm(z ~ x1 + x2 + x3)
summary(res_test)

vif(res_test)

x4 <- rnorm(100, 50, 10)
res_test <- lm(z ~ x1+x2+x3+x4)
vif(res_test)

x3 <- x1 + x2 + rnorm(100, 0, 1)
res_test <- lm(z ~ x1 + x2 + x3)
summary(res_test)
vif(res_test)

f <- function(x, y) x*y
x <- y <- seq(-2, 2, length=30)
z <- outer(x, y ,f)
persp(x, y, z, theta=60, phi=20, expand=0.7, ticktype="detailed")

plot(airquality[, 1:4])
res <- lm(Ozone ~ Solar.R + Wind + Temp, data=airquality)
summary(res)

res.interact <- lm(Ozone ~ (Solar.R + Wind + Temp)^2, data=airquality)
summary(res.interact)
AIC(res)
AIC(res.interact)

library(ISLR)

head(Carseats)
res <- lm(Sales ~ . - ShelveLoc, data=Carseats)
summary(res)
