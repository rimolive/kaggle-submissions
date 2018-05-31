library(tidyverse)
library(caret)

setwd("house-prices")

houses.train <- read.csv("train.csv")
houses.test <- read.csv("test.csv")

ggplot(houses.train, aes(MSSubClass, SalePrice)) +
  geom_point()
ggplot(houses.train, aes(MSZoning, SalePrice)) +
  geom_point()
ggplot(houses.train, aes(YearBuilt, SalePrice, color=MSZoning)) +
  geom_point()

ggplot(houses.train, aes(MSSubClass)) +
  geom_histogram(binwidth = 10)
ggplot(houses.train, aes(YearBuilt)) +
  geom_histogram(binwidth = 5)
