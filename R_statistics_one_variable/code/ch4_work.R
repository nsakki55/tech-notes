# 4-10
discunif <- function(n=100, a=1, b=10){
  dur <- as.integer(runif(n, a, b))
  return(dur)
}
discunif(10, 3, 10)
