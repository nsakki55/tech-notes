head(cars)
plot(cars$speed, cars$dist)
res2 <- lm(dist ~ speed + I(speed^2), data=cars)
summary(res2)
lines(cars$speed, fitted(res2))

res1 <- lm(dist ~ speed, data=cars)
res2 <- lm(dist ~ poly(speed, 2, raw=TRUE), data=cars)
res3 <- lm(dist ~ poly(speed, 3, raw=TRUE), data=cars)
res4 <- lm(dist ~ poly(speed, 4, raw=TRUE), data=cars)
plot(cars)
lines(cars$speed, fitted(res2))
lines(cars$speed, fitted(res3))
lines(cars$speed, fitted(res4))

summary(res1)$r.squared; summary(res1)$adj.r.squared
summary(res2)$r.squared; summary(res2)$adj.r.squared
summary(res3)$r.squared; summary(res3)$adj.r.squared
summary(res4)$r.squared; summary(res4)$adj.r.squared

AIC(res1)
AIC(res2)
AIC(res3)
AIC(res4)

res02 <- lm(dist ~ poly(speed, 2, raw=TRUE) - 1, data=cars)
summary(res02)
AIC(res02)

x <- seq(-5, 5, length=1000)
y <- seq(-5, 5, length=1000)
z <- outer(x, y, function(x, y) x^2/(2*y^2)+log(y)+(1/y^2+1)/2)
contour(x, y, z, levels=seq(0.01, 3, by=0.5))
