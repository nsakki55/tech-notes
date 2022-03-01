logit <- function(x) return (log(x/(1-x)))
curve(logit)

data <- read.csv('data/Beetle.csv')
head(data)
beetle <- cbind(data$dead.beetle, data$num.beetle)
beetle
head(data)

res <- glm(formula = beetle~data$gas, family=binomial(link="logit"))
summary(res)

logistic <- function(x) return(exp(x)/(1+exp(x)))
curve(logistic(-19.829 + 10.664*x), add=TRUE)

res2 <- glm(formula = beetle~data$gas, family=binomial(link="probit"))
summary(res2)
coefficients(res2)

curve(dnorm, xlim=c(-4, 4), ylim=c(0, 0.5), ylab='density')
d <- sqrt(3) / pi
curve(1/(d*(exp(x/(2*d)) + exp(-x/(2*d)))^2), xlim=c(-4, 4), ylim=c(0, 0.5), add=TRUE, lwd=2)

library(effects)
head(TitanicSurvival)
summary(TitanicSurvival)

plot(TitanicSurvival$passengerClass, TitanicSurvival$survived)
plot(TitanicSurvival$sex, TitanicSurvival$survived)

titanic <- glm(survived ~ passengerClass + sex + age, data=TitanicSurvival, family = binomial)
summary(titanic)
exp(coef(titanic))

library(MASS)
exp(confint(titanic))
