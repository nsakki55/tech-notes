library(psy)
data(expsy)
expsy

expsy2 <- expsy[, 1:10]
expsy2

expsy2$it2r <- 4 - expsy2$it2
expsy3 <- expsy2[, c(1, 11, 3:10)]
expsy3

scale_score <- rowSums(expsy3)
length(scale_score)
       
expsy4 <- cbind(expsy3, scale_score)
expsy4

cronbach(expsy4[, 1:10])
