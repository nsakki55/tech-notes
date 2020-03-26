data <- read.csv('chap15data.csv')
data

attach(data)
lm(daughter ~ father + mother)

summary(lm(daughter ~ father + mother))

result <- lm(daughter ~ father + mother)
coef(result)[2:3] * sd(result[,2:3]) / sd(result[, 1])

coef(result)

single_result <- update(result, .~., -mother)
single_result
summary(single_result)

summary(lm(daughter ~ father))
 
single_result = lm(daughter ~ father)
plot(father, daughter)
abline(single_result)


