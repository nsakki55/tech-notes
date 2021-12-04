data <- read.csv('/Users/satsuki/Documents/tech-notes/R_EmpiricalAnalysis/author_code/R_EmpiricalAnalysis/02 演習用データ集/Ch8.data.csv')
head(data)
plot(data$T, data$Y, xlim=c(-0.5,1.5),ylim=c(0,100),xaxt="n",cex=2)

mean(data[data$T==1, ]$Y)
mean(data[data$T==0, ]$Y)
Y <- data$Y
T <- data$T
lm(Y~T)
sum(T*Y)/sum(T) - sum((1-T)*Y)/sum(1-T)

motiv <- data$motiv
summary(lm(Y ~ T + motiv))

cor(motiv, T)
cor(motiv, Y)
cor(Y, T)
