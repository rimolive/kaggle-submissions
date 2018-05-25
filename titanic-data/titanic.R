library(dplyr)
library(caret)

setwd("C:/Arquivos/Dados/")

titanic.train <- read.csv("./train.csv", stringsAsFactors = F)
titanic.test <- read.csv("./test.csv", stringsAsFactors = F)
#glimpse(titanic.train)

features <- c("Pclass", "Sex", "Age", "SibSp", "Parch", "Survived")
titanic.train <- titanic.train[features]

titanic.train$Survived <- as.factor(titanic.train$Survived)
levels(titanic.train$Survived) <- c("No", "Yes")

set.seed(926)
fitControl <- trainControl(method = "cv",
                           number = 10)

nbTrain <- train(Survived~.,
                 data = titanic.train,
                 method="naive_bayes",
                 trControl=fitControl,
                 verbose = F)

features <- c("Pclass", "Sex", "Age", "SibSp", "Parch")
titanic.test <- na.omit(titanic.test[features])

nbPred <- predict(nbTrain, data = titanic.test)

submission <- data.frame(PassengerId=titanic.test$PassengerId, Survived=as.numeric(nbPred))


