# 11-1

data <- read.csv('data/British Doctors.csv')
deathrate <- as.integer(data$deaths/data$pym*100000)
smoke <- 1:5; nonsmoke <- 6:10
smkdummy <- c(1, 1, 1, 1, 1, 0, 0, 0, 0, 0)
agecat <- c(1:5, 1:5)
res <- glm(deathrate ~ smkdummy*agecat + I(agecat^2), family=poisson)
res2 <- glm(deathrate ~ smkdummy*agecat, family=poisson)
AIC(res, res2)

res3 <- glm(deathrate ~ smkdummy + agecat + I(agecat^2), family=poisson)
summary(res3)
AIC(res3)

# 11-2
head(warpbreaks)
A <- warpbreaks[which(warpbreaks$wool == "A"), ]
B <- warpbreaks[which(warpbreaks$wool == "B"), ]
plot(A$tension, A$breaks)
plot(B$tension, B$breaks)
