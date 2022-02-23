# 12-2
logL <- function(r,n,p) return(log(choose(n,r)) + r*log(p) + (n-r)*log(1-p))
optimize(logL, n=12, r=5, lower=0, upper=1, maximum=TRUE)
