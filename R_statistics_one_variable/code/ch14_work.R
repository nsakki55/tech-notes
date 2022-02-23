# 14-2
x <- c(35, 29, 29, 28, 27, 26, 24, 23, 17, 14)
y <- c(19, 19, 16, 15, 15, 14, 14, 13, 12, 10)
t.test(x, y)

# 14-3
x <- c(15, 15, 15, 15, 15, 15, 14, 14, 12, 11)
y <- c(15 ,14, 13, 13, 13, 13, 13, 13, 12, 12) 
t.test(x, y)

# 14- 4
group1 <- sleep$extra[sleep$group==1]
group2 <- sleep$extra[sleep$group==2]
t.test(group1, group2, alternative = "less", paired = TRUE)

# 14-5
data <- read.csv('data/csv/statistics test.csv')
A <- data$A
B <- data$B
B <- B[!is.na(B)]

mean(A)
mean(B)
sd(A)
sd(B)
median(A)
median(B)

boxplot(A, B, names=c("A", "B"))

t.test(A, B)

# 14-6
before <- c(18, 12, 16, 15, 20)
after <- c(15, 13, 14, 11, 17)
before - after
t.test(before, after, paired = TRUE, alternative = "greater")

# 14-7
n <- 10000
result <- numeric(n)
for (i in 1:n) {
  x <- rnorm(10, 50, 10)
  result[i] <- as.integer(t.test(x, mu=50)$p.value < 0.05)  
}
sum(result) / length(result)


