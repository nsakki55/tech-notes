data <- read.csv('shidouhou.csv',header=T,fileEncoding="CP932")

psych_test <- data$psych_test
test1 <- data$stat_test1
test2 <- data$stat_test2

plot(test1, test2)
plot(psych_test, test1)
plot(psych_test, test2)

cor_test1_test2 <- sum((test1-mean(test1)) * (test2-mean(test2))) / length(test1)
cor_test1_test2

cor_test1_test2_ver2 <- mean((test1-mean(test1)) * (test2-mean(test2))) 
cor_test1_test2_ver2

cov(test1, test2)
cov(test1, test2) * (length(test1) -1) / length(test1) 

cov(test1, test2) / (sd(test1) * sd(test2))
cor(test1, test2)
cor(psych_test, test1)
cor(psych_test, test2)

math <- data$math
table(math)

stat <- data$stat
table(stat)

table(math, stat)

math_10 <- ifelse(math == 'D‚«', 1, 0)
stat_10 <- ifelse(stat == 'D‚«', 1, 0)

cor(math_10, stat_10)

# —ûK–â‘è
time <- c(1, 3, 10, 12, 6, 3, 8, 4, 1, 5)
score <- c(20, 40, 100, 80, 50, 50, 70, 50, 10, 60)
plot(time, score)

cor(time, score)


