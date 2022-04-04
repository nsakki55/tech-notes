# 14-1
data <- read.csv("data/ANOVA.csv")
head(data)
LA2016 <- data$score[data$year==2016]
LA2017 <- data$score[data$year==2017]
LA2018 <- data$score[data$year==2018]
boxplot(LA2016, LA2017, LA2018)

# 14-2

head(data)

# 14-3
aov.warpbreaks <- aov(breaks ~ wool + tension, data=warpbreaks)
summary(aov.warpbreaks)
HSD.warpbreaks <- TukeyHSD(aov.warpbreaks)
HSD.warpbreaks
plot(HSD.warpbreaks)
