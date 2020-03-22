data <- read.csv('shidouhou.csv',header=T,fileEncoding="CP932")

psych_test <- data$psych_test
test1 <- data$stat_test1
test2 <- data$stat_test2

plot(test1, test2)
plot(psych_test, test1)
plot(psych_test, test2)

