fish <- read.csv('../book-data/2-2-1-fish.csv')
head(fish, n=2)

hist(fish$length)
kernel_density <- density(fish$length)
plot(kernel_density)


kernel_density_1 <- density(fish$length, adjust=0.25)
kernel_density_2 <- density(fish$length, adjust=4)

plot(kernel_density,lwd=2, xlab='', ylim = c(0, 0.26), main = 'バンド幅を変える')
lines(kernel_density_1, col=2)
lines(kernel_density_2, col=4)

legend('topleft', col = c(1, 2, 4), lwd = 1, bty = 'n', legend = c('標準', '1/4', '4'))

mean(fish$length)

suuretu <- 0:1000
suuretu

length(suuretu)
median(suuretu)
quantile(suuretu, probs = c(0.5))
quantile(suuretu, probs = c(0.25, 0.75))
quantile(suuretu, probs = c(0.025, 0.975))

birds <- read.csv('../book-data/2-1-1-birds.csv')
cor(birds$body_length, birds$feather_length)

Nile
acf(
  Nile,
  type = 'covariance',
  plot = 'F',
  lag.max = 5
)


acf(
  Nile,
  plot = 'F',
  lag.max = 5
)

acf(Nile)
