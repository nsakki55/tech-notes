# 演習問題
a <- c(60, 100, 50, 40, 50, 230, 120, 240, 200, 30)
b <- c(50, 60, 40, 50, 100, 80, 30, 20, 100, 120)
hist(a)
hist(b)
a_mean <- mean(a)
b_mean <- mean(b)

a_var <- var(a)
b_var <- var(b)

a_std <- sqrt(a)
b_std <- sqrt(b)

a_standard <- (a - a_mean) / a_std
b_standard <- (b - b_mean) / b_std
