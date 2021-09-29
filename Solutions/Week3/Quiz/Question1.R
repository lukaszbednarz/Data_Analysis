library(ElemStatLearn)

# q1
data(bone)
plot(bone$age,bone$spnbmd,pch=19,col=((bone$gender=="male")+1))

#q2
data(marketing)
boxplot(marketing$Income ~ marketing$Marital,col="grey",xaxt="n",ylab="Income",xlab="",varwidth=TRUE)
axis(side=1,at=1:5,labels=c("Married","Living together/not married","Divorced or separated","Widowed","Nevermarried"),las=2)

#q3
library(datasets)
data(iris)
summary(iris)

irisSubset <- subset(iris, select = 1:4)
irisMatrix <- as.matrix(irisSubset)

heatmap(irisMatrix)

distxy <- dist(irisSubset)

hClustering <- hclust(distxy)

plot(hClustering)
lines(c(0,150),c(3,3))

# q4
download.file("https://spark-public.s3.amazonaws.com/dataanalysis/quiz3question4.csv", destfile = "quiz3question4.csv")
data <- read.csv("quiz3question4.csv")

plot(data$x,data$y, pch=19)

dataFrame <- data[,2:3]
dkmeansObj <- kmeans(dataFrame,centers=2, iter.max = 100, nstart =10)

par(mar=rep(0.2,4))
plot(data$x,data$y,col=dkmeansObj$cluster,pch=19,cex=2)
points(dkmeansObj$centers,col=1:3,pch=3,cex=3,lwd=3)

distxy <- dist(dataFrame)

hClustering <- hclust(distxy, method = "single")

plot(hClustering)

cut <- cutree(hClustering, 2)

plot(data$x,data$y,col=cut,pch=19,cex=2)


# q5
data(zip.train)

im = zip2image(zip.train,3)
image(im)

im8 = zip2image(zip.train,8)
image(im8)
svd8 <- svd(im8)
plot(svd8$d^2/sum(svd8$d^2),xlab="Column",ylab="Singluar value",pch=19)

svd8$d^2/sum(svd8$d^2)[1]

im18 = zip2image(zip.train,18)
image(im18)
svd18 <- svd(im18)
plot(svd18$d^2/sum(svd18$d^2),xlab="Column",ylab="Singluar value",pch=19)

svd18$d^2/sum(svd18$d^2)[1]

