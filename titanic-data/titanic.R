library(dplyr)
library(caret)

setwd("titanic-data")

titanic.train <- read.csv("train.csv", stringsAsFactors = F)
titanic.test <- read.csv("test.csv", stringsAsFactors = F)
glimpse(titanic.train)

features <- c("Pclass", "Sex", "Age", "SibSp", "Parch", "Survived")
titanic.train <- titanic.train[features]

titanic.train$Survived <- as.factor(titanic.train$Survived)
levels(titanic.train$Survived) <- c("No", "Yes")
titanic.train[is.na(titanic.train$Age) == TRUE, ]$Age <- as.integer(mean(na.omit(titanic.train)$Age))
sapply(titanic.train, function(x) {sum(is.na(x))})

set.seed(926)
fitControl <- trainControl(method = "cv",
                           number = 10)

nbTrain <- train(Survived~.,
                 data = titanic.train,
                 method="naive_bayes",
                 trControl=fitControl,
                 verbose = F)

titanic.test[is.na(titanic.test$Age) == TRUE, ]$Age <- as.integer(mean(na.omit(titanic.test)$Age))
sapply(titanic.test, function(x) {sum(is.na(x))})
features <- c("Pclass", "Sex", "Age", "SibSp", "Parch")
titanic.test <- titanic.test[features]

nbPred <- predict(nbTrain, titanic.test)
titanic.test <- read.csv("test.csv", stringsAsFactors = F)
submission <- data.frame(PassengerId=titanic.test$PassengerId, Survived=as.numeric(nbPred))
submission$Survived <- submission$Survived - 1


write.csv(submission, "submission.csv", row.names = F)
