library(MASS)
SmokeEx <- table(survey$Smoke, survey$Exer)
chisq.test(SmokeEx)

sb <- matrix(c(1085, 703, 55623, 441239), 2, 2)
chisq.test(sb, correct=FALSE)
chisq.test(sb)

prop.test(c(8, 13), c(20, 20))
bluepen <- matrix(c(8, 13, 12, 7), 2, 2)
bluepen
chisq.test(bluepen)

bluepen <- matrix(c(8, 13, 12, 7), 2, 2)
fisher.test(bluepen)

mrecall <- matrix(c(14, 6, 17, 2), 2, 2)
mrecall
chisq.test(mrecall)
fisher.test(mrecall)

MF <- matrix(c(482, 532, 303, 390, 30, 38,  29, 62), 4, 2, dimnames=list(c('機械', '電気', '電子', '環境'), c('男性', '女性')))
res <- chisq.test(MF)
res
res$stdres

p.value.matrix <- pnorm(abs(res$stdres), lower.tail=FALSE)*2
p.value.matrix
round(p.value.matrix, 4) * 100 

