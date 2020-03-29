fish <- read.csv('data/2-2-1-fish.csv')
fish

hist(fish$length)

kernel_density <- density(fish$length)
plot(kernel_density, add=TRUE)

kernel_density_quarter <- density(fish$length, adjust = 0.25)
kernel_density_4 <- density(fish$length, adjust =4)

plot(kernel_density, 
     lwd = 2,
     ylim = c(0, 0.26))

lines(kernel_density_quarter, col=2)
lines(kernel_density_4, col=6)

legend('topleft',
        col = c(1, 2, 4),
        lwd = 1,
        bty = 'n',
        legend=c('1', '2', '3'))

quantile(fish$length)

birds <- read.csv('data/2-1-1-birds.csv')

plot(birds$body_length,birds$feather_length)

cor(birds$body_length,birds$feather_length)

Nile

acf(
  Nile,
  type = 'covariance',
  plot = F,
  leg.max = 5)
