#data <- read.csv('shidouhou.csv',header=T,fileEncoding="CP932")
data <- read.csv('data/shidouhouU8.csv')
data



curve(df(x, 3, 16), 0, 5)

A <- data[data$method=='A',]$stat_test2
B <- data[data$method=='B',]$stat_test2
C <- data[data$method=='C',]$stat_test2
D <- data[data$method=='D',]$stat_test2

stat2 <- c(A, B, C, D)
method <- c(rep('A', 5), rep('B', 5), rep('C', 5), rep('D', 5))
method2 <- factor(method)
method2

oneway.test(stat2 ~ method2, var.equal=TRUE)
aov(stat2~method2)

summary(aov(stat2~method2))

anova(lm(stat2~method2))

all_data <- cbind(A, B, C, D)
all_data

group_mean <- colMeans(all_data)
group_mean

all_mean <- mean(all_data)
all_mean

all_mean_mat <- matrix(rep(all_mean, 20), nrow=5, ncol=4)
all_mean_mat

group_mean_mat <- matrix(rep(group_mean, 5), nrow=5, ncol=4, byrow=TRUE)
group_mean_mat

total <- all_data - all_mean_mat
total

group_dif <- group_mean_mat - all_mean_mat
group_dif

group_inner <- all_data - group_mean_mat
group_inner

all_data^2

total^2
group_dif^2
group_inner^2

total_sqrt_sum <- sum(total^2)
total_sqrt_sum

group_sqrt_sum <- sum(group_dif^2)
group_sqrt_sum

summary(aov(stat2~method2))

TukeyHSD(aov(stat2~method2))

preference <- c(7, 8, 9, 5, 6, 5, 4, 7, 1, 3, 8, 6, 7, 2, 5)
subject <- factor(c(rep('seneki', 5), rep('biseki', 5), rep('tokei', 5)))
subject

summary(aov(preference ~ subject))

human <- factor(rep(c('A', 'B', 'C', 'D', 'E'), 3))
human

summary(aov(preference ~ subject + human))
qf(0.05, 2, 8, lower.tail=FALSE)

taste <- c(6, 4 ,5, 3, 2, 10, 8, 10, 8, 9, 11, 12, 12, 10, 10, 5, 4, 2, 2, 2, 7, 6, 5, 4, 3, 12, 8, 5, 6, 4)
temperature <- factor(c(rep('reizoko', 15), rep('zyoon', 15)))
meigara <- factor(rep(c(rep('ikaan', 5), rep('bosivic', 5), rep('bibiteru', 5)), 2))
meigara
length(temperature)

summary(aov(taste ~ temperature*meigara))
summary(aov(taste ~ temperature + meigara + temperature:meigara))

interaction.plot(temperature, meigara, taste)
interaction.plot(meigara, temperature, taste)

summary(aov(taste ~ temperature))

human1 <- factor(rep(1:5, 6))
human1

summary(aov(taste~temperature*meigara + Error(human1 + human1:temperature + human1:meigara + human1:temperature:meigara)))

human2 <- factor(c(rep(1:5, 3), rep(6:10, 3)))
human2

summary(aov(taste ~ temperature*meigara + Error(human2:temperature + human2:temperature:meigara)))

# 練習問題
gakubu <- c(rep('hogaku', 8), rep('bungaku', 8), rep('rigaku', 8), rep('kogaku', 8))
test <- c(75, 61, 68, 58, 66, 55, 65, 63, 62, 60, 66, 63, 55, 53, 59, 63, 65,
           60, 78, 52, 59, 66, 73, 64, 52, 59, 44, 67, 47, 53, 58, 49)

summary(aov(test ~ gakubu))
TukeyHSD(aov(test ~ gakubu))

