data <- read.csv('data/prepost.csv')
data

attach(data)
pre
summary(lm(post~pre+group))

plot(post, group)

summary(aov(post ~ pre +group))
summary(aov(post ~ pre * group))

dif <- post - pre
dif
data

var.test(dif ~ group)

t.test(dif ~ group, var.equal=TRUE)
