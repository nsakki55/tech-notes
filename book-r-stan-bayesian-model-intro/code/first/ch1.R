1+1
3-1
3*4
8/6
2^10

x<-2
x+1

sqrt(2)

vector <- c(1, 2, 3, 4, 5)
vector

1:10

matrix_1 <- matrix(
  data = 1:10,
  nrow = 2,
  byrow = TRUE
)
matrix_1

rownames(matrix_1) <- c('Row1', 'Row2')
colnames(matrix_1) <- c('Col1', 'Col2', 'Col3', 'Col4', 'Col5')
matrix_1

array_1 <- array(
  data = 1:30,
  dim = c(3, 5, 2)
)
array_1

data_frame <- data.frame(
  col1 = c('A', 'B', 'C', 'D'),
  col2 = 1:4
)
data_frame
nrow(data_frame)
ncol(data_frame)


list_1 <- list(
  chara = c('A', 'B', 'C'),
  matrix = matrix_1,
  df = data_frame
)

list_1

vector
vector[1:3]

matrix_1
matrix_1[2, 3]

array_1
array_1[1, 2, 1]

matrix_1[1,]
matrix_1[, 1]

matrix_1[1, 2:4]

dim(matrix_1)
dim(array_1)

dimnames(matrix_1)

matrix_1['Row1', 'Col2']

data_frame
data_frame$col1
data_frame$col1[2]

head(data_frame, n=2)

list_1$chara
list_1[[1]]

data_frame2 <- data.frame(
  data = 1:24
)

ts_1 <- ts(
  data = data_frame2,
  start = c(2010, 1),
  frequency = 12
)
ts_1

birds <- read.csv('../book-data/2-1-1-birds.csv')
head(birds, n=3)

rnorm(n=1, mean=0, sd=1)
rnorm(n=1, mean=0, sd=1)

set.seed(1)
rnorm(n=1, mean=0, sd=1)
rnorm(n=1, mean=0, sd=1)

for (i in 1:3){
  print(i)
}

result_vec_1 <- c(0, 0, 0)
set.seed(1)
for (i in 1:3){
  result_vec_1[i] <- rnorm(n=1, mean=0, sd=1)
}
result_vec_1

result_vec_2 <- c(0, 0, 0)
mean_vec <- c(0, 10, -5)
set.seed(1)
for (i in 1:3){
  result_vec_2[i] <- rnorm(n=1, mean=mean_vec[i], sd=1)
}
result_vec_2

library(tidyverse)
