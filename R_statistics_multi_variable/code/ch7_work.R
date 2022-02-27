# 7-2
library('car')
res2 <- lm(prestige ~ education + income, data=Prestige)
summary(res2)
res <- lm(prestige ~ education + log(income), data=Prestige)
AIC(res, res2)

# 7-5
res0 <- lm(I(log(Output)-log(Capital)) ~ I(log(Labor) - log(Capital)), data=econ)
summary(res0)
