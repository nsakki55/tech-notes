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
test1
