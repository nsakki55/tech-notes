animal <- read.csv('animal.csv')[,2:4]
colnames(animal) <- c('Species', 'Body_weight', 'Brain_weight')

animal
plot(animal$Body_weight, animal$Brain_weight)
cor(animal$Body_weight, animal$Brain_weight)

condition1 <- animal$Body_weight < 80000
animal2 <- animal[condition1, ]

plot(animal2$Body_weight, animal2$Brain_weight)
cor(animal2$Body_weight, animal2$Brain_weight)

condition2 <- animal$Body_weight < 2000
animal3 <- animal[condition2, ]

plot(animal3$Body_weight, animal3$Brain_weight)
cor(animal3$Body_weight, animal3$Brain_weight)

condition3 <<- animal$Body_weight < 2000 & animal$Brain_weight<1000
animal4 <- animal[condition3, ]

plot(animal4$Body_weight, animal4$Brain_weight)
cor(animal4$Body_weight, animal4$Brain_weight)

