library(ggplot2)
fish <- read.csv('data/2-2-1-fish.csv')
ggplot(data = fish, mapping = aes(x = length)) + 
    geom_histogram(alpha=0.5, bins=20)

ggplot(data = fish, mapping = aes(x = length)) + 
  geom_density(alpha=1.5)

ggplot(data = fish, mapping = aes(x = length, y = ..density..)) + 
  geom_histogram(alpha=0.5, bins=20) +
  geom_density(size=1.5)

library(gridExtra)

p_hist <- ggplot(data = fish, mapping = aes(x = length)) + 
  geom_histogram(alpha=0.5, bins=20)

p_density <- ggplot(data = fish, mapping = aes(x = length)) + 
  geom_density(alpha=1.5)

grid.arrange(p_hist, p_density, nrow=2)

head(iris, 3)

p_box <- ggplot(data = iris, mapping = aes(x = Species, y = Petal.Length)) +
    geom_boxplot()

p_violin <- ggplot(data = iris, mapping = aes(x = Species, y = Petal.Length)) +
  geom_violin()

grid.arrange(p_box, p_violin, ncol=2)

ggplot(data=iris, mapping=aes(x=Petal.Width, y= Petal.Length, color=Species )) + 
  geom_point()

Nile

df <- data.frame(
  year = 1871:1970,
  Nile = as.numeric(Nile)
)

as.numeric(Nile)

df
ggplot(data=df, mapping=aes(x=year, y=Nile)) +
    geom_line()


library(ggfortify)
autoplot(Nile)

ggplot(data=df, mapping=aes(x=Nile)) +
  geom_histogram()


