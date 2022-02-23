# 2-1
data <- c(48, 52, 59, 71, 64, 50, 35, 49)
res <- chisq.test(data)
res
p.value.matrix <- pnorm(abs(res$stdres), lower.tail=FALSE)*2 
p.value.matrix

barplot(data)

# 2-2
data <- matrix(c(220-57, 266-48, 57, 48), 2, 2)
data
res <- chisq.test(data)
res
p.value.matrix <- pnorm(abs(res$stdres), lower.tail=FALSE)*2 
p.value.matrix

# 2-3
data <- matrix(c(90, 22, 2, 186), 2, 2)
data
chisq.test(data)

# 2-4
flu <- matrix(c(1, 15, 22, 62), 2, 2)
flu
chisq.test(flu)
