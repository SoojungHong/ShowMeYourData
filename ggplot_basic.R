# install ggplot2 package 
library(ggplot2)

head(iris)
head(iris, n = 10)

# plotting in x-y coordinates 
qplot(Sepal.Length, Petal.Length, data = iris)

# give different colors to different group
qplot(Sepal.Length, Petal.Length, data = iris, color = Species)

#also shows the Sized by Petal width
qplot(Sepal.Length, Petal.Length, data = iris, color = Species, size = Petal.Width) 

# By setting the alpha of each point to 0.7, we reduce the effects of overplotting.
qplot(Sepal.Length, Petal.Length, data = iris, color = Species, size = Petal.Width, alpha = I(0.7))

qplot(Sepal.Length, Petal.Length, data = iris, color = Species,
      xlab = "Sepal Length", ylab = "Petal Length",
      main = "Sepal vs. Petal Length in Fisher's Iris data")
