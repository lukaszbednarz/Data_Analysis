setwd("C:/Users/Lukasz/Documents/R/Week5");

# q1
data(warpbreaks)

aovObj <- aov(breaks ~ wool + tension, data=warpbreaks)

# q3

library(glm2)
data(crabs)

glm1 <- glm(crabs$Satellites ~ crabs$Width, family="poisson")

summary(glm1)

plot(crabs$Satellites ~ crabs$Width, col ="blue", pch=19)
lines(crabs$Width,glm1$fitted,col="blue",lwd=3)

exp(glm1$coefficients[2])

# q4

exp(glm1$coefficients[1] + 22* glm1$coefficients[2])

# q5
library(MASS)
data(quine) 
lm1 = lm(log(Days + 2.5) ~.,data=quine)

aicFormula <- step(lm1)