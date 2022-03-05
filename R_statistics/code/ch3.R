data <-read.csv("data/shidouhouU8.csv")
psy <- data$psych_test
stat1 <- data$stat_test1
stat2 <- data$stat_test2
plot(stat1, stat2)
plot(psy, stat1)

covar_1_2 <- mean((stat1 - mean(stat1)) * (stat2 - mean(stat2))) 
covar_1_2
cov(stat1, stat2)

cov(stat1, stat2) * (length(stat1) - 1) / length(stat1)

cov(stat1, stat2) / (sd(stat1) * sd(stat2))
cor(stat1, stat2)
cor(psy, stat1)
