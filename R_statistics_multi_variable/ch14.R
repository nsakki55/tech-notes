data <- read.csv("data/ANOVA.csv")
head(data)
tapply(data$score, data$year, mean)
tapply(data$score, data$year, sd)
stripchart(score ~ factor(year), data=data, vert=TRUE, method="jitter", jit=0.05, pch=16)

install.packages("gplots")
library(gplots)
plotmeans(score ~ year, data=data)
oneway.test(score~ factor(year), data = data)
oneway.test(score~ factor(year), data = data, var.equal = TRUE)


res <- aov(score~ factor(year), data = data)
summary(res)
res.lm <- lm(score ~ factor(year), data=data)
anova(res.lm)

m <- 10; n <- 4
num <- 100000
X <- rchisq(num ,df =m)
Y <- rchisq(num ,df =n)
Z <- (X/m)/(Y/n)
hist(Z, prob=TRUE, xlim=c(0, 6), breaks=8000)
curve(df(x, df1=10, df2=4), add=TRUE)

pairwise.t.test(data$score, data$year, p.adjust.methods="bonferroni")

pairwise.t.test(data$score, data$year, p.adjust.methods="holm")
p.adjust.methods

n <- 30
k <- 5
total <- n*k
trial <- 10000
mu <- 0
noisevar <- 1
q <- numeric(trial)
for(i in 1:trial) {
  x <- rnorm(n*k, mu, noisevar)
  xmat <- matrix(x, n, k)
  mus <- apply(xmat, 1, mean)
  S <- sum((n-1)*var(mus))/(total-k)
  q[i] <- (max(mus) - min(mus))/(S/sqrt(n))
}
hist(q,prob=TRUE)

head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, length)
stripchart(count~spray, data=InsectSprays, vert=TRUE, method="jitter", jit=0.05, pch=16)
oneway.test(count~spray, data = InsectSprays)
oneway.test(count~spray, data = InsectSprays, var.equal = TRUE)

res.insect <- aov(count ~ spray, data=InsectSprays)
summary(res.insect)
res.Turkey <- TukeyHSD(res.insect)
res.Turkey
plot(res.Turkey)

head(warpbreaks)
aov.warpbreaks <- aov(breaks ~ wool + tension, data=warpbreaks)
summary(aov.warpbreaks)
HSD.warpbreaks <- TukeyHSD(aov.warpbreaks)
HSD.warpbreaks
