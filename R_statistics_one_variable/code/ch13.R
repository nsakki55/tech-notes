qnorm(0.975)
n <- 100
hmean <- 170.1
hsd <- 5.8
hmean + qnorm(0.975)*hsd/sqrt(n)
hmean - qnorm(0.975)*hsd/sqrt(n)

height <- c(170.1, 169.3, 180.2, 165.8, 163.9)
n <- length(height)
mean(height) + qt(0.975, n-1)*sd(height)/sqrt(n)
mean(height) - qt(0.975, n-1)*sd(height)/sqrt(n)

mean(height) + qnorm(0.975)*sd(height)/sqrt(n)
mean(height) - qnorm(0.975)*sd(height)/sqrt(n)

t.test(height, mu=160)
t.test(height, mu=160, conf.level = 0.9)

n <- 30
plot(c(0, n), c(35, 65), type="n", axes=FALSE, xlab="", ylab="")
axis(1)
abline(h=50)
y1 <- y2 <- numeric(n)
for (i in 1:n) {
  y <- rnorm(20, 50, 10)
  y1[i] <- t.test(y)$conf.int[1]
  y2[i] <- t.test(y)$conf.int[2]
  segments(i, y1[i], i, y2[i], lwd=2)
}

data <- read.csv('data/csv/blood pressure.csv')
high <- data$systolic.blood.pressure
n <- length(high)
plot(c(0, n), c(90, 140), type="n", xlab="", ylab="")
#axis(1)
#abline(h=50)
y1 <- y2 <- numeric(n)
for (i in 1:n) {
  y1[i] <- t.test(high[1:i])$conf.int[1]
  y2[i] <- t.test(high[1:i])$conf.int[2]
  segments(i, y1[i], i, y2[i], lwd=2)
}

qt(0.975, 99)
qt(0.975, 999)

degf <- 10:200
qtf <- qt(0.975, degf)
plot(degf, qtf, type="l", ylim=c(1.9, 2.25))
abline(h=qnorm(0.975), lwd=2)
