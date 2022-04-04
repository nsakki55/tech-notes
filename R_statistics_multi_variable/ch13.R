data <- read.csv('data/Math-Phys.csv')
math <- data$math
phys <- data$phys
mp <- cbind(math, phys)
res <- prcomp(mp, scale=TRUE)
summary(res)

R <- cor(mp)
L <- eigen(R)$values
L
L[1]/ sum(L)
res$rotation

head(USArrests)
res.pc <- prcomp(USArrests, scale=TRUE)
summary(res.pc)

C <- cor(USArrests)
C
eigen(C)$values
round(eigen(C)$values/4, 5)
res.pc$sdev^2
res.pc$rotation
head(res.pc$x)
screeplot(res.pc, main="PC")
boxplot(res.pc$x)
par(xpd=TRUE)
biplot(res.pc)
