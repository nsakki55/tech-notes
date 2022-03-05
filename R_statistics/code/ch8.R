vec <- -5:5
vec
vec <- seq(1, 5, 1)
vec
vec <- seq(2, 10, 2)
vec
vec <- rep(1, 8)
vec

vece <- 10:20
vece[1]

vece[3:7]
vecf <- vece[c(2, 4, 6, 8)]
vecf

vecf <- vece[c(10, 1, 8, 6)]
vecf

matrix(1:12, nrow=3, ncol=4)
matrix(1:12, nrow=3, ncol=4, byrow=TRUE)

veca <- 1:5
vecb <- seq(2, 10, 2)
cbind(veca, vecb)
rbind(veca, vecb)

mata <- matrix(1:6, nrow=2, ncol=3)
rownames(mata) <- c('row1', 'row2')
colnames(mata) <- c('col1', 'col2', 'col3')
mata

matb <- matrix(3:8, nrow=2, ncol=3)
mata + matb

matbt <- t(matb)
matbt

matbt %*% mata

diag(c(1, 2, 3))
diag(3)

matd <- matrix(1:25, nrow=5, ncol=5)
matd

matd[,2]
matd[2,]
matd[, c(1, 3)]
matd[c(1, 4), ]
matd[2, 4]


