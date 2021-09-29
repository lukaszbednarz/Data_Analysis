setwd("C:/Users/Lukasz/Documents/R/Week8");

# q2

set.seed(3343)
pValues = rep(NA,100)
for(i in 1:100){
  z = rnorm(20)
  x = rnorm(20)
  y = rnorm(20,mean=0.5*x)
  pValues[i] = summary(lm(y ~ x))$coef[2,4]
}

plot(pValues)
sum(p.adjust(pValues,method="bonferroni") < 0.1)
abline(b=0, a=0.1/100, ,col="red")

sum(p.adjust(pValues,method="BH") < 0.1)
abline(a= 0, b=0.1/100,col="blue")

# q4

# y = 1 + 2*x + e

# case 1

b <- rep(NA,1000)

for (i in 1:1000)
{
  x <- rnorm(1000)
  
  x <- order(x)[1:900]
  
  e <- rnorm(900) 
  y <- 1 + 2*x +e
  
  b[i] <- lm(y ~ x)$coef[2]
  
}

mean(b)

plot(density(b))

# case 2

b2 <- rep(NA,1000)

for (i in 1:1000)
{
  x <- rnorm(1000)
   
  e <- rnorm(1000) 
  
  y <- 1 + 2*x +e
  
  y_sort <- sort(y, index.return=T)
  
  ind <- y_sort$ix[1:900]
  
  b2[i] <- lm(y[ind] ~ x[ind])$coef[2]
  
}

mean(b2)

plot(density(b2))


# q5

library("MASS")

# case 1

b3 <- rep(NA,1000)

for (i in 1:1000)
{
  x <- rnorm(1000)
  
  x <- order(x)[1:900]
  
  e <- rnorm(900) 
  y <- 1 + 2*x +e
  
  b3[i] <- rlm(y ~ x)$coef[2]
  
}

mean(b3)

plot(density(b3))

# case 2

b4 <- rep(NA,1000)

for (i in 1:1000)
{
  x <- rnorm(1000)
  
  e <- rnorm(1000) 
  
  y <- 1 + 2*x +e
  
  y_sort <- sort(y, index.return=T)
  
  ind <- y_sort$ix[1:900]
  
  b4[i] <- rlm(y[ind] ~ x[ind])$coef[2]
  
}

mean(b4)

plot(density(b4))