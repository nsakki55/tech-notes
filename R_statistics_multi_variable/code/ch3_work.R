# 3-3
head(airquality)
plot(airquality$Wind, airquality$Ozone)
res <- lm(Ozone ~ Wind, data=airquality)
abline(res)
summary(res)

# 3-4
head(mtcars)
plot(mtcars$disp, mtcars$mpg)
res <- lm(mpg ~ disp, data=mtcars)
abline(res)
summary(res)
