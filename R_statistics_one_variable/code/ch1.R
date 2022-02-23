data <- read.csv('data/csv/Math&Phys.csv')
data
length(data$math)
math <- data$math

hist(math)
mean(math)
var(math)
sd(math)

sqrt(var(math) * (length(math) - 1) / length(math))

x <- c(1.2, 1.1, 1.05)
prod(x) ^ (1 / length(x))

v <- c(60, 20)
1 /mean(1/v)
1/ v

# histgramのビン幅を調整
hist(math, breaks = 'scott')
hist(math, breaks = 'FD')
hist(math, breaks = 18)
hist(math, breaks = seq(0, 100, 10))

# 画像を保存
jpeg("math.jpg", width = 60, height=480)
hist(math)
dev.off()

# 分位点
score <- c(56, 78, 90)
median(score)

score <- c(56, 78, 81, 90)
median(score)

quantile(math)
IQR(math)
boxplot(math)

head(iris)
tail(iris)
str(iris)
boxplot(iris[, 1:3])
boxplot(iris[, c(1,3, 4)])

# モード
names(which.max(table(math)))
table(math)
x <- c("Alice", "Bob", "Chris", "Alice", "Alice", "Alice", "Chris")
which.max(table(x))

# 欠損値
NA + 1
mean(NA)
NA == 1
NA != 1
a <- 1
a == 1
a != 1
TRUE + 1
FALSE + 1

data <- read.csv("data/csv/Not Available.csv")
head(data)
math_na <- data$math_na
mean(math_na)
math_na2 <- c(NA, math_na)
math_na2
mean(math_na2)
mean(math_na2, na.rm = TRUE)
head(is.na(math_na2))

