data <- read.csv('data/csv/Math&Phys.csv')
math <- data$math
phys <- data$phys
hist(phys)
plot(math, phys)

cor(math, phys)
cov(math, phys)
cor.test(math, phys)

cor(math, phys, method="spearman")
cor(math, phys, method="kendall")

cor.test(math, phys, method="spearman")
cor.test(math, phys, method="kendall")

x <- seq(0, 1, by=0.01)
y <- x^4
plot(x, y)
cor(x, y)
cor(x, y, method="spearman")
cor(x, y, method="kendall")

data <- read.csv("data/csv/Not Available2.csv")
na.omit(data)

data <- read.csv("data/csv/Not Available2.csv", na.strings = c("XX"))
data
na.omit(data)

data2 <- subset(data, complete.cases(data))
data2
