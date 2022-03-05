#data <- read.csv('shidouhou.csv',header=T,fileEncoding="CP932")
data <- read.csv('data/shidouhouU8.csv')
stat1_man <- data[data$sex=='男', ]$stat_test1
stat1_woman <- data[data$sex=='女', ]$stat_test1
stat1_man
stat1_woman


var_pool <- sqrt(((length(stat1_man) - 1) * var(stat1_man) + (length(stat1_woman) - 1) * var(stat1_woman)) / (length(stat1_man) + length(stat1_woman) - 2))
var_pool

t_stat <- (mean(stat1_man) - mean(stat1_woman)) /  (var_pool * sqrt(1/length(stat1_man) + 1/length(stat1_woman)))
t_stat
qt(0.025, length(stat1_man) + length(stat1_woman) - 2)
qt(0.025, length(stat1_man) + length(stat1_woman) - 2, lower.tail = FALSE)

pt(-1.842885, 18)
2 * pt(-1.842885, 18)

t.test(stat1_man, stat1_woman, var.equal = TRUE)

A <- c(54, 55, 52, 48, 50, 38, 41, 40, 53, 52)
B <- c(67, 63, 50, 60, 61, 69, 43, 58, 36, 29)
var.test(A, B)

t.test(A, B, var.equal=FALSE)

stat1 <- data$stat_test1
stat2 <- data$stat_test2

dif <- stat1 - stat2
mean(stat1)
mean(stat2)
mean(dif)

D <- stat2 - stat1
D

sd(D)
t_stat <- mean(D) / (sd(D)/sqrt(length(D)))
t_stat
qt(0.025, length(D) - 1)
qt(0.025, length(D) - 1, lower.tail = FALSE)

t.test(D)

t.test(stat1, stat2, paired=TRUE)

var.test(stat1, stat2)
t.test(stat1, stat2)

# 練習問題
stat1_like <- data[data$stat=='好き', ]$stat_test1
stat1_dislike <- data[data$stat=='嫌い', ]$stat_test1
D <- stat1_like - stat1_dislike

sd(D)
t_stat <- mean(D) / (sd(D)/sqrt(length(D)))
t_stat
qt(0.025, length(D) - 1)
qt(0.025, length(D) - 1, lower.tail = FALSE)

t.test(D)

data

psych_man <- data[data$sex=='男', ]$psych_test
psych_woman <- data[data$sex=='女', ]$psych_test

D = psych_man - psych_woman
t_stat <- mean(D) / (sd(D)/sqrt(length(D)))
t_stat
qt(0.025, length(D) - 1)
qt(0.025, length(D) - 1, lower.tail = FALSE)
t.test(D)

before <- c(61, 50, 41, 55, 52, 48, 46, 66, 65, 70)
after <- c(59, 48, 33, 54, 47, 52, 38, 50, 64, 63)
D = after - before
t_stat <- mean(D) / (sd(D)/sqrt(length(D)))
t_stat
qt(0.025, length(D) - 1)
qt(0.025, length(D) - 1, lower.tail = FALSE)
t.test(D)

