data <- read.csv('shidouhou.csv',header=T,fileEncoding="CP932")
psych_test <- data$psych_test
psych_test

Z_stat <- (mean(psych_test) - 12) / sqrt(10/length(psych_test))
Z_stat

qnorm(0.025) # 下側確率
qnorm(0.975)　# 上側確率
qnorm(0.025, lower.tail=FALSE)
qnorm(0.025, lower.tail=TRUE)

curve(dnorm(x), -3, 3)
abline(v=qnorm(0.025))
abline(v=qnorm(0.975))

# p value
2*pnorm(2.828427, lower.tail=FALSE)

curve(dt(x, 8), -5, 5)
curve(dt(x, 4), -5, 5, add=TRUE)
curve(dt(x, 2), -5, 5, add=TRUE)
curve(dt(x, 1), -5, 5, add=TRUE)

t_stat <- (mean(psych_test) - 12) / sqrt(var(psych_test)/length(psych_test))
t_stat

qt(0.025, length(psych_test)-1)
qt(0.975, length(psych_test)-1)

curve(dt(x, 19), -3, 3)
abline(v=qnorm(0.025))
abline(v=qnorm(0.975))

pt(-2.616648, 19)
pt(2.616648, 19, lower.tail = FALSE)
2*pt(2.616648, 19, lower.tail = FALSE)

t.test(psych_test, mu=12)

test1 <- data$stat_test1
test2 <- data$stat_test2
sample_cor <- cor(test1, test2)
sample_cor
sample_size <- length(test1)
sample_size

t <- (sample_cor*sqrt(sample_size-2)) / sqrt(1-sample_cor^2)
t
qt(0.025, sample_size-2)
qt(0.975, sample_size-2)

# p value
2*pt(4.805707, sample_size-2, lower.tail=FALSE)

cor.test(test1, test2)
cor.test(test1, test2, method='spearman')

curve(dchisq(x, 2), 0, 20)
curve(dchisq(x, 1), 0, 20, add=TRUE)
curve(dchisq(x, 4), 0, 20, add=TRUE)
curve(dchisq(x, 8), 0, 20, add=TRUE)
curve(dchisq(x, 50), 0, 100)

math <- data$math
stat <- data$stat
table(math, stat)

expect <- c(12*14/20, 12*6/20, 8*14/20, 6*8/20) 
expect

observe <- c(10, 2, 4, 4)
kai <- (observe - expect)^2 / expect 
kai
kai_sq <- sum(kai)
kai_sq

qchisq(0.95, 1)

qchisq(0.05, 1, lower.tail=FALSE)

pchisq(2.539683, 1, lower.tail = FALSE)

1 -pchisq(2.539683, 1)

chisq.test(table(math, stat), correct=FALSE)

qchisq(0.05, 1, lower.tail=FALSE)

A <- matrix(c(16, 12, 4 ,8), 2, 2)
rownames(A) <- c('bunkei', 'rikei')
colnames(A) <- c('risyu', 'risyunasi')
chisq.test(A, correct=FALSE)

B <- matrix(c(160, 120, 40, 80), 2, 2)
chisq.test(B, correct=FALSE)

# 練習問題
a <- c(165, 150, 170, 168, 159, 170, 167, 178, 155, 159)
b <- c(161, 162, 166, 171, 155, 160, 168, 172, 155, 167)
t.test(a, b)

time <- c(1, 3, 10, 12, 6, 3, 8, 4, 1, 5)
score <- c(20, 40, 100, 80, 50, 50, 70, 50, 10, 60)
cor.test(time, score)

cor.test(time, score, method='spearman')
cor.test(time, score, method='kendall')

kokugo <- c(60, 40, 30, 70, 55)
sansu <- c(80, 25, 35, 70, 50)
cor.test(kokugo, sansu)

