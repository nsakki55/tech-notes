# 13-2
res.pca.noscale <- prcomp(USArrests)
summary(res.pca.noscale)
par(xpd=TRUE)
biplot(res.pca.noscale)

# 13-3
head(iris)

data <- cbind(iris$Sepal.Length, iris$Sepal.Width, iris$Petal.Length, iris$Petal.Width)
res <- prcomp(data)
summary(res)

boxplot(res)
par(xpd=TRUE)
biplot(res)

res.pca <- prcomp(data, scale=TRUE)
pc1 <- res.pca$x[, 1]
pc2 <- res.pca$x[, 2]
pchlabels <- as.integer(iris[, 5]) - 1
plot(pc1, pc2, pch=pchlabels)
