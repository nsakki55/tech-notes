library('car')
Prestige
plot(Prestige[c(1, 2, 4)])
income <- Prestige$income
hist(income, breaks=10, prob=TRUE)
curve(dlnorm(x, meanlog = mean(log(income)), sdlog=sd(log(income))), add=TRUE)

res <- lm(prestige ~ education + log(income), data=Prestige)
summary(res)

head(trees)
plot(trees)
cor(trees)
res <- lm(Volume ~ Girth + Height, data=trees)
summary(res)
res_VG <- lm(log(Volume) ~ log(Girth), data=trees)
summary(res_VG)
res_VGH <- update(res_VG, ~ . + log(Height), data=trees)
summary(res_VGH)
AIC(res_VG, res_VGH)


econ <- read.csv('data/Production.csv', header = T)
plot(econ$Year, log(econ$Output), type="l", xlab="", yalb="", ylim=c(4.5, 6.2), lwd=2, lty="solid")
par(new=TRUE)
plot(econ$Year, log(econ$Labor), type="l", xlab="", yalb="", ylim=c(4.5, 6.2), lwd=2, lty="dotted")
par(new=TRUE)
plot(econ$Year, log(econ$Capital), type="l", xlab="", yalb="", ylim=c(4.5, 6.2), lwd=2, lty="dotdash")

res <- lm(log(Output) ~ log(Labor) + log(Capital), data=econ)
summary(res)
