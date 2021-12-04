data <- read.csv('/Users/satsuki/Documents/tech-notes/R_EmpiricalAnalysis/author_code/R_EmpiricalAnalysis/02 演習用データ集/data_4_1.csv')
head(data)

plot(data$time, data$temp, xlab='time', ylab='temp')
with(data, plot(elec, prec))

group12 <- data[data$time==12, ]
group12
mean(group12$temp)
mx <- numeric(24)
for(i in 0:23){
  group <- data[data$time==i, ]
  mx[i+1] <- mean(group$temp)
}
plot(0:23, mx, type='l', xlab='time', ylab='temp', ylim=c(20, 30))
par(new=TRUE)
plot(data$time, data$temp, xlab='time', ylab='temp', ylim=c(20, 30))

with(data, plot(temp, elec))

res <- lm(data$elec ~ data$temp)
res

plot(data$temp, data$elec)
abline(res)

plot(data$time, data$elec)
daytime <- (data$time >= 9) & (data$time <= 18)

res <- lm(data$elec ~ data$temp + daytime)
res
res <- lm(data$elec ~ data$temp + daytime + data$prec)
res
with(data, lm(elec ~ temp + daytime + prec))

sunday <- with(data,(date=="2014/8/3")|(date=="2014/8/10")| +
                 (date=="2014/8/17")|(date=="2014/8/24")|(date=="2014/8/31"))


recess <- with(data,(date=="2014/8/11")|(date=="2014/8/12")| +
                 (date=="2014/8/13")|(date=="2014/8/14")| +
                 (date=="2014/8/15")|(date=="2014/8/16"))


with(data, lm(elec ~ temp + daytime + prec + sunday + recess))
summary(with(data, lm(elec ~ temp + daytime + prec + sunday + recess)))
summary(with(data, lm(elec ~ temp)))

ehat <- res$residuals
sum(ehat)
sum(data$temp*ehat)


## 練習問題
data2 <- read.csv('/Users/satsuki/Documents/tech-notes/R_EmpiricalAnalysis/author_code/R_EmpiricalAnalysis/02 演習用データ集/data_3_2.csv',colClasses = "character", header = T)
head(data2)

data2$icecream <- as.numeric(data2$icecream)
data2$income <- as.numeric(data2$income)


res <- lm(data2$icecream ~data2$income)
plot(data2$income, data2$icecream)
abline(res)
res

data3 <- read.csv('/Users/satsuki/Documents/tech-notes/R_EmpiricalAnalysis/author_code/R_EmpiricalAnalysis/02 演習用データ集/data_Males.csv')
head(data3)
res <- with(data3, lm(wage ~ school))
plot(data3$school, data$wage)
abline(res)

res <- with(data3, lm(wage ~ school + exper))
res
