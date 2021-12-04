data <- read.csv('/Users/satsuki/Documents/tech-notes/R_EmpiricalAnalysis/author_code/R_EmpiricalAnalysis/02 演習用データ集/Ch6.data.csv')
head(data)
grade <- data$grade
hours <- data$hours

plot(hours, grade)

data <- read.csv('/Users/satsuki/Documents/tech-notes/R_EmpiricalAnalysis/author_code/R_EmpiricalAnalysis/02 演習用データ集/police_crime.csv', colClasses = "character", header = T)
data$police <- as.numeric(data$police)
data$crime <- as.numeric(data$crime)
head(data)

plot(data$police, data$crime)

n <- 400
T <- rbinom(n, 1, 0.6)
TE <- 2
Y <- TE*T + rnorm(n)
T
EY1 <- sum(T*Y) / sum(T)
EY0 <- sum((1-T)*Y) / sum(1-T)
EY1 - EY0

Z <- runif(n)
T <- rbinom(n, 1, Z)
T
Y <- TE*T + (2*Z - 1)
Y
EY1 <- sum(T*Y) / sum(T)
EY0 <- sum((1-T)*Y) / sum(1-T)
EY1 - EY0
