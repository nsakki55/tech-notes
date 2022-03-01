# 8-1
head(airquality)

res <- lm(Ozone ~ Solar.R + Wind + Temp, data=airquality)
res.interact <- lm(Ozone ~ (Solar.R + Wind + Temp)^2, data=airquality)
res.question <- lm(Ozone ~ Wind + Temp + Solar.R:Temp + Wind:Temp,data=airquality)
AIC(res)
AIC(res.interact)
AIC(res.question)

# 8-2
library('car')
res <- lm(prestige ~ (education + log(income))^2, data=Prestige)
res2 <- lm(prestige ~ education + log(income), data=Prestige)
summary(res)
head(Prestige)
AIC(res2)
AIC(res)
