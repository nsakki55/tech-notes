dbinom(17, 20, 0.5)
win_num <- 1:20
win_num

dbinom(win_num, 20, 0.5)

plot(win_num, dbinom(win_num, 20, 0.5), type='h')
plot(win_num, dbinom(win_num, 20, 0.5), type='p')

pbinom(win_num, 20, 0.5)

round(pbinom(win_num, 20, 0.5), 4)

pbinom(16, 20, 0.5, lower.tail=FALSE)

true_count <- 0:10
round(pbinom(true_count, 10, 1/3), 4)
pbinom(6, 10, 1/3, lower.tail = FALSE)
