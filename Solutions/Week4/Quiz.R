# q1
setwd("C:/Users/Lukasz/Documents/R/Week3");
download.file("https://spark-public.s3.amazonaws.com/dataanalysis/movies.txt", destfile = "movies.txt")

movies <- read.table("movies.txt",sep="\t",header=T,quote="")

head(movies)

lm1 <- lm(movies$score ~ movies$box.office)

summary(lm1)

plot(movies$box.office, movies$score, pch=19, col="blue")

lines(0:350, lm1$coeff[1] + lm1$coeff[2]*(0:350), col="red", pch="-")

# q2
confint(lm1, level=0.9)

# q3

lm2 <- lm(movies$score ~ movies$box.office + movies$running.time)

summary(lm2)

# q4
cor(movies[,c("score", "box.office", "running.time")])

lm3 <- lm(movies$box.office ~ movies$running.time)
summary (lm3)

# q5
plot(movies$score, movies$running.time, pch=19, col="blue")

plot(movies$running.time, movies$score, pch=19, col="blue")

moviesFilt <- movies[movies$running.time < 180,]

plot(moviesFilt$score, moviesFilt$running.time, pch=19, col="blue")

lm4 <- lm(moviesFilt$score ~ moviesFilt$box.office + moviesFilt$running.time)

summary(lm4)


# q6

lm5 <- lm(movies$score ~ movies$running.time + movies$box.office)

summary(lm5)

# q7 
lm6 <- lm(movies$score ~ movies$rating + movies$running.time + movies$rating*movies$running.time)
summary(lm6)

# q9

data(warpbreaks)

head(warpbreaks)

summary(warpbreaks)

lm7 <- lm(warpbreaks$breaks ~ relevel(warpbreaks$tension, ref="H"))

summary(lm7)

confint(lm7)

