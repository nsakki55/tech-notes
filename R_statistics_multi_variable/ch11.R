deaths

data <- read.csv('data/British Doctors.csv')
data
deathrate <- as.integer(data$deaths/data$pym*100000)
smoke <- 1:5; nonsmoke <- 6:10
plot(smoke, deathrate[smoke], xlab="", ylab="", ylim=c(0, 2200), xaxt="n", yaxt="n", pch=19)
par(new=TRUE)
plot(nonsmoke, deathrate[nonsmoke], xlab="age", ylab="death rate", ylim=c(0, 2200), xaxt="n", yaxt="n", pch=17)
axis(1, at=nonsmoke, labels=data$agelabel[1:5])
legend("topleft", legend=c("smoker", "nonsmoker"), pch=c(19, 17))

smkdummy <- c(1, 1, 1, 1, 1, 0, 0, 0, 0, 0)
agecat <- c(1:5, 1:5)
res <- glm(deathrate ~ smkdummy*agecat + I(agecat^2), family=poisson)
summary(res)
exp(res$coefficients[2])

x <- 0:60
plot(x, dnbinom(x, size=10, prob=0.3), lwd=6, type="h", xlab="y", ylab="Probability")

head(warpbreaks)
A <- warpbreaks[which(warpbreaks$wool == "A"), ]
B <- warpbreaks[which(warpbreaks$wool == "B"), ]
plot(A$tension, A$breaks)
plot(B$tension, B$breaks)

res.all <- glm(breaks ~ wool*tension, data=warpbreaks, family=poisson)
summary(res.all)

library(MASS)
nbres.all <- glm.nb(breaks ~ wool*tension, data=warpbreaks)
summary(nbres.all)

res.nb <- glm.nb(deathrate ~ smkdummy*agecat + I(agecat^2))
summary(res.nb)
