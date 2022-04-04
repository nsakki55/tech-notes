data <- read.csv('data/csv/Earthquake.csv')
M <- data$M
N <- data$N
plot(M, log10(N))
head(data)

data <- read.csv('data/csv/^N225.csv', na.strings = c("null"))
Nikkei255 <- subset(data, complete.cases(data))
head(Nikkei255)
plot(as.Date(Nikkei255$Date), Nikkei255$Close, type="l", lwd=3)

Nikkei255Logdiff <- diff(log(Nikkei255$Close))
hist(Nikkei255Logdiff, 150, xlim = c(-0.18, 0.18))
Nikkei255Logdiff_z <- (Nikkei255Logdiff - mean(Nikkei255Logdiff)) / sd(Nikkei255Logdiff)
hist(Nikkei255Logdiff_z, 150, prob=TRUE)
curve(dnorm, add=TRUE, lty=2)

(max(Nikkei255Logdiff) - mean(Nikkei255Logdiff)) / sd(Nikkei255Logdiff)
(min(Nikkei255Logdiff) - mean(Nikkei255Logdiff)) / sd(Nikkei255Logdiff)
1- pnorm(9.296245)
1 - pnorm(11.35015)

library(poweRlaw)
me <- mean(Nikkei255Logdiff)
sdev <- sd(Nikkei255Logdiff)
N255pos <- conpl$new(Nikkei255Logdiff_z[Nikkei255Logdiff_z  > 0])
N255neg <- conpl$new(-Nikkei255Logdiff_z[Nikkei255Logdiff_z  < 0])
est_pos <- estimate_xmin(N255pos)
est_neg <- estimate_xmin(N255neg)
N255pos$setXmin(est_pos)
N255neg$setXmin(est_neg)
plot(N255pos)
lines(N255pos, lwd=2)
