data <- read.csv('shidouhou.csv',header=T,fileEncoding="CP932")
data

table(data$method)
table(data[,9])
data[9, ]
hist(data$psych_test)

data$psych_test
attach(data)
psych_test

max(psych_test)
min(psych_test)

for (i in 6:8){
  print(mean(data[, i]))
}

z_score <- scale(psych_test)
z_score

hensati <- 10*z_score + 50
hensati

mean(hensati)
var(hensati)

plot(data$stat_test1, data$stat_test2)
cov(data$stat_test1, data$stat_test2)
cor(data$stat_test1, data$stat_test2)

table(data$math, data$stat)
cor(as.integer(data$math), as.integer(data$stat))
as.integer(data$math)

t.test(data$psych_test, mu=12)
cor.test(data$stat_test1, data$stat_test2)

cross_table <- table(data$math, data$stat)
chisq.test(cross_table, correct = FALSE)

t.test(data$stat_test1 ~ data$sex, var.equal=TRUE) 

stat_man <- data$stat_test1[data$sex=='男']
stat_woman <- data$stat_test1[data$sex=='女']
t.test(stat_man, stat_woman, var.equal = TRUE)

t.test(data$stat_test1, data$stat_test2, paired = TRUE)

bartlett.test(data$stat_test2, data$method)
bartlett.test(data$stat_test2 ~ data$method)
oneway.test(data$stat_test2 ~ data$method, var.equal=TRUE)
TukeyHSD(aov(data$stat_test2 ~ data$method))

edit(data)
