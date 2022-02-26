# 4-1
res<- lm(weight ~ height, data=women)
res2<- lm(weight ~ poly(height, 2, raw=TRUE), data=women)
plot(women)
lines(women$height, fitted(res))
lines(women$height, fitted(res2))
summary(res)
summary(res2)
AIC(res, res2)

# 4-4
x <- seq(-5, 5, length=1000)
y <- seq(0.1, 8, length=1000)
z <- outer(x, y, function(x, y) x^2/(2*y^2)+log(y)+(1/y^2+1)/2)
filled.contour(x, y, z, levels=seq(0.01, 3, by=0.5))

