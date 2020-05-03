A <- rnorm(n=10)
B <- rnorm(n=10)
C <- rnorm(n=10)

A
B
C  

result <- t.test(A, B, var.equal = TRUE)
result
length(result)
result[1]
result$statistic

for(i in 1:length(result)){
  print(result[i])
}

result$p.value

result1 <- t.test(A, B, var.equal = TRUE)
result2 <- t.test(B, C, var.equal = TRUE)
result3 <- t.test(C, A, var.equal = TRUE)

ifelse(result1$p.value<0.05 | result2$p.value<0.05 | result3$p.value<0.05, 'false', 'right')

trial = 10000
count <- 0
for(i in 1:trial){
  A <- rnorm(n=10)
  B <- rnorm(n=10)
  C <- rnorm(n=10)
  result1 <- t.test(A, B, var.equal = TRUE)
  result2 <- t.test(B, C, var.equal = TRUE)
  result3 <- t.test(C, A, var.equal = TRUE)
  
  count <- count + ifelse(result1$p.value<0.05 | result2$p.value<0.05 | result3$p.value<0.05, 1, 0)
}
count