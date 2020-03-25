data <- read.csv('prepost.csv')
data

attach(data)

summary(lm(post~pre+group))

summary(aov(post ~ pre +group))
summary(aov(post ~ pre * group))

dif <- post - pre
data

var.test(dif ~ group)

t.test(dif ~ group, var.equal=TRUE)
