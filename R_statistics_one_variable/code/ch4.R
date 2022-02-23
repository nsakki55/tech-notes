curve(dunif, from=-1, to=2)
curve(punif, from=-1, to=2)
qunif(0.95, min=0, max=1)
qnorm(0.95, mean=0, sd=1)
qnorm(pnorm(1.1))
pnorm(qnorm(0.3))
runif(6)
runif(6)

set.seed(100)
runif(6)
runif(6)
 
x <- runif(6, 1, 7)
as.integer(x)
cd