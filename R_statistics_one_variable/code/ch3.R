data <- read.csv('data/csv/Math&Phys.csv')
math <- data$math
phys <- data$phys
cor(math, phys)
cor(math[math<60], phys[math<60])
cor(math[math>=60], phys[math>=60])
cor(math[math+phys>=120], phys[math+phys>=120])
  
x <- rnorm(20, 30, 10)
y <- rnorm(20, 30, 10)
cor(x, y)
xa <- c(x, 100)
ya <- c(y, 100)
cor(xa, ya)

data()
airquality
head(airquality)

plot(airquality[, 1:4])

iris_mat <- iris[, 1:4]
var(iris_mat)

