library(ggplot2)
fish <- read.csv('../book-data/2-2-1-fish.csv')
head(fish, n=3)

ggplot(data=fish, mapping=aes(x = length)) + geom_histogram(alpha=0.5, bins=20) + labs(title='histgram')

ggplot(data=fish, mapping=aes(x = length)) + geom_density(size=1.5) + labs(title='kernel density')

ggplot(data=fish, mapping=aes(x=length, y=..density..)) + geom_histogram(alpha=0.5, bins=20) + geom_density(size=1.5) + labs(title = '重ね合わせ')


library(gridExtra)

p_hist <- ggplot(data=fish, mapping=aes(x=length)) + geom_histogram(alpha=0.5, bins=20)+ labs(title='histgram')
p_density <- ggplot(data=fish, mapping=aes(x = length)) + geom_density(size=1.5) + labs(title='kernel density')

grid.arrange(p_hist, p_density, ncol=2)

head(iris, n=3)

p_box <- ggplot(data=iris, mapping=aes(x=Species, y=Petal.Length)) + geom_boxplot() + labs(title='box plot')

p_violin <- ggplot(data=iris, mapping=aes(x=Species, y=Petal.Length)) + geom_violin() + labs(title='violin plot')

grid.arrange(p_box, p_violin, ncol=2)

ggplot(data=iris, mapping=aes(x=Petal.Width, y=Petal.Length, color=Species)) + geom_point() + labs(title='scatter plot')

Nile

nile_data_frame <- data.frame(
  year = 1871:1970,
  Nile = as.numeric(Nile)
)
head(nile_data_frame)

ggplot(data = nile_data_frame, mapping = aes(x = year, y = Nile)) + geom_line()

library(ggfortify)
autoplot(Nile)
Nile
