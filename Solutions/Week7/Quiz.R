setwd("C:/Users/Lukasz/Documents/R/Week7");

# q2
set.seed(53535)
xValues = seq(0,2*pi,length=100)
yValues = rnorm(100) + sin(xValues)

library(splines)

res <- rep(NA,10)

for (i in 1:10)
{
  par(mfrow=c(1,i))
  ns1 <- ns(xValues,df=i)
  
  for (j in 1: i )
#   plot(xValues,ns1[,j]);
  
  lm1 <- lm(yValues ~ ns1)
  summary(lm1)
  
  res[i] <- sqrt(sum(lm1$residuals^2))
  
  par(mfrow=c(1,1))
  plot(xValues, yValues)
  lines(xValues,lm1$fitted, col="red")

}


# q3
library(simpleboot) 
data(airquality)
attach(airquality)

summary(airquality)

quantile(airquality$Wind, .75)

plot(density(airquality$Wind))

set.seed(883833)

boot75 <- one.boot(airquality$Wind, quantile, 1000, probs=.75)

summary(boot75)

plot(density(boot75$t))

summary(boot75$t)

sd(as.vector(boot75$t))
      
boot75



# q4
library(tree)

data(Cars93,package="MASS")

summary(Cars93)

trees <- list()

prediction <- list()

new_data = data.frame(Type = "Large",Price = 20)

set.seed(7363)


for (i in 1:3)
{
  samp = Cars93[sample(nrow(Cars93), replace=T),]
  
  trees[[i]] <- tree(DriveTrain ~ Price + Type, data = samp)
    
  prediction[[i]] <- predict(trees[[i]], newdata= new_data )
  
}

stat <- function(x,i) { samp=Cars93[i,]
                        tree1 <- tree(DriveTrain ~ Price + Type, , data=samp)
                        predict(tree1, newdata= new_data )[2]                      
                        }

bs1 <- boot(Cars93, stat)


prediction

# q5
library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)

library(randomForest)
set.seed(33833)
forestVow <- randomForest(y ~ .,data=vowel.train,prox=TRUE)
forestVow

sum(predict(forestVow, newdata=vowel.test) != as.numeric(vowel.test$y))/length(vowel.test$y)

library(e1071)
svmVow <- svm(y ~ .,data=vowel.train)

sum(predict(svmVow, newdata=vowel.test) != as.numeric(vowel.test$y))/length(vowel.test$y)

ind = predict(svmVow, newdata=vowel.test) == predict(forestVow, newdata=vowel.test)

sum(predict(svmVow, newdata=vowel.test)[ind] != as.numeric(vowel.test$y[ind]))/sum(ind)

