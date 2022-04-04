# 10-3
library("MASS")
head(menarche)
res <- lm(Menarche/Total ~ Age, data=menarche)
plot(menarche$Age, menarche$Menarche/menarche$Total)
abline(res)

res2 <- glm(cbind(Menarche, Total-Menarche) ~ Age, family=binomial(logit), data=menarche)
summary(res2)
plot(menarche$Age, menarche$Menarche/menarche$Total)
lines(menarche$Age, res2$fitted, type="l")

# 1-4
head(mtcars)
subdata <- subset(mtcars, select = c(mpg, vs))
head(subdata)
res <- glm(vs ~ mpg, data=subdata, family=binomial(link='logit'))
summary(res)
res2 <- glm(vs ~ mpg, data=subdata, family=binomial(link='probit'))
summary(res2)
AIC(res)
AIC(res2)
plot(subdata$mpg, subdata$vs)
curve(predict(res2, data.frame(mpg=x), type="response"), add=TRUE)
curve(predict(res, data.frame(mpg=x), type="response"), add=TRUE, type="p")

# 10-5
titanic2 <- glm(survived ~ passengerClass + sex + age + sex:age, data=TitanicSurvival, family = binomial)
summary(titanic2)
exp(coef(titanic2))
AIC(titanic2)
