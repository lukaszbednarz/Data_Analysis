Raw Loans Analysis
========================

------

### Load libraries


```r
# library(maps) library(Hmisc)
```




------

## Processing

Download the data, read the data in and save the raw data as an RDA file


```r
setwd("C:/Users/Lukasz/Documents/R/AssignmentProject_1/code/rawcode")
getwd()
```

```
## [1] "C:/Users/Lukasz/Documents/R/AssignmentProject_1/code/rawcode"
```

```r
download.file("https://spark-public.s3.amazonaws.com/dataanalysis/loansData.csv", 
    destfile = "../../data/loansData.csv", method = "auto")
```

```
## Error: unsupported URL scheme
```

```r
dateDownloaded <- date()
dateDownloaded
```

```
## [1] "Sat Feb 16 00:53:38 2013"
```

```r
loansRaw <- read.csv("../../data/loansData.csv")
save(loansRaw, dateDownloaded, file = "../../data/loanRaw.rda")
```



### Look at the data set


```r
head(loansRaw)
```

```
##       Amount.Requested Amount.Funded.By.Investors Interest.Rate
## 81174            20000                      20000         8.90%
## 99592            19200                      19200        12.12%
## 80059            35000                      35000        21.98%
## 15825            10000                       9975         9.99%
## 33182            12000                      12000        11.71%
## 62403             6000                       6000        15.31%
##       Loan.Length       Loan.Purpose Debt.To.Income.Ratio State
## 81174   36 months debt_consolidation               14.90%    SC
## 99592   36 months debt_consolidation               28.36%    TX
## 80059   60 months debt_consolidation               23.81%    CA
## 15825   36 months debt_consolidation               14.30%    KS
## 33182   36 months        credit_card               18.78%    NJ
## 62403   36 months              other               20.05%    CT
##       Home.Ownership Monthly.Income FICO.Range Open.CREDIT.Lines
## 81174       MORTGAGE           6542    735-739                14
## 99592       MORTGAGE           4583    715-719                12
## 80059       MORTGAGE          11500    690-694                14
## 15825       MORTGAGE           3833    695-699                10
## 33182           RENT           3195    695-699                11
## 62403            OWN           4892    670-674                17
##       Revolving.CREDIT.Balance Inquiries.in.the.Last.6.Months
## 81174                    14272                              2
## 99592                    11140                              1
## 80059                    21977                              1
## 15825                     9346                              0
## 33182                    14469                              0
## 62403                    10391                              2
##       Employment.Length
## 81174          < 1 year
## 99592           2 years
## 80059           2 years
## 15825           5 years
## 33182           9 years
## 62403           3 years
```

```r
summary(loansRaw)
```

```
##  Amount.Requested Amount.Funded.By.Investors Interest.Rate 
##  Min.   : 1000    Min.   :    0              12.12% : 122  
##  1st Qu.: 6000    1st Qu.: 6000              7.90%  : 119  
##  Median :10000    Median :10000              13.11% : 115  
##  Mean   :12406    Mean   :12002              15.31% :  76  
##  3rd Qu.:17000    3rd Qu.:16000              14.09% :  72  
##  Max.   :35000    Max.   :35000              14.33% :  69  
##                                              (Other):1927  
##     Loan.Length               Loan.Purpose  Debt.To.Income.Ratio
##  36 months:1952   debt_consolidation:1307   0%     :   8        
##  60 months: 548   credit_card       : 444   12.54% :   6        
##                   other             : 201   12.20% :   5        
##                   home_improvement  : 152   12.85% :   5        
##                   major_purchase    : 101   14.22% :   5        
##                   small_business    :  87   14.66% :   5        
##                   (Other)           : 208   (Other):2466        
##      State       Home.Ownership Monthly.Income     FICO.Range  
##  CA     : 433   MORTGAGE:1148   Min.   :   588   670-674: 171  
##  NY     : 255   NONE    :   1   1st Qu.:  3500   675-679: 166  
##  TX     : 174   OTHER   :   5   Median :  5000   680-684: 157  
##  FL     : 169   OWN     : 200   Mean   :  5689   695-699: 153  
##  IL     : 101   RENT    :1146   3rd Qu.:  6800   665-669: 145  
##  GA     :  98                   Max.   :102750   690-694: 140  
##  (Other):1270                   NA's   :1        (Other):1568  
##  Open.CREDIT.Lines Revolving.CREDIT.Balance Inquiries.in.the.Last.6.Months
##  Min.   : 2.0      Min.   :     0           Min.   :0.000                 
##  1st Qu.: 7.0      1st Qu.:  5586           1st Qu.:0.000                 
##  Median : 9.0      Median : 10962           Median :0.000                 
##  Mean   :10.1      Mean   : 15245           Mean   :0.906                 
##  3rd Qu.:13.0      3rd Qu.: 18889           3rd Qu.:1.000                 
##  Max.   :38.0      Max.   :270800           Max.   :9.000                 
##  NA's   :2         NA's   :2                NA's   :2                     
##  Employment.Length
##  10+ years:653    
##  < 1 year :250    
##  2 years  :244    
##  3 years  :235    
##  5 years  :202    
##  4 years  :192    
##  (Other)  :724
```

```r
sapply(loansRaw[1, ], class)
```

```
##               Amount.Requested     Amount.Funded.By.Investors 
##                      "integer"                      "numeric" 
##                  Interest.Rate                    Loan.Length 
##                       "factor"                       "factor" 
##                   Loan.Purpose           Debt.To.Income.Ratio 
##                       "factor"                       "factor" 
##                          State                 Home.Ownership 
##                       "factor"                       "factor" 
##                 Monthly.Income                     FICO.Range 
##                      "numeric"                       "factor" 
##              Open.CREDIT.Lines       Revolving.CREDIT.Balance 
##                      "integer"                      "integer" 
## Inquiries.in.the.Last.6.Months              Employment.Length 
##                      "integer"                       "factor"
```


### Find out about missing values

```r
sum(is.na(loansRaw))
```

```
## [1] 7
```

```r

naLoansRaw <- loansRaw[!complete.cases(loansRaw), ]

naLoansRaw
```

```
##        Amount.Requested Amount.Funded.By.Investors Interest.Rate
## 101596             5000                       4525         7.43%
## 101515             3500                        225        10.28%
##        Loan.Length Loan.Purpose Debt.To.Income.Ratio State Home.Ownership
## 101596   36 months        other                   1%    NY           NONE
## 101515   36 months        other                  10%    NY           RENT
##        Monthly.Income FICO.Range Open.CREDIT.Lines
## 101596             NA    800-804                NA
## 101515          15000    685-689                NA
##        Revolving.CREDIT.Balance Inquiries.in.the.Last.6.Months
## 101596                       NA                             NA
## 101515                       NA                             NA
##        Employment.Length
## 101596          < 1 year
## 101515          < 1 year
```


### Take only complete observations

```r

loansComplete <- loansRaw[complete.cases(loansRaw), ]
```


### Have a look at some factor values

```r
table(loansComplete$Loan.Length)
```

```
## 
## 36 months 60 months 
##      1950       548
```

```r
table(loansComplete$Loan.Purpose)
```

```
## 
##                car        credit_card debt_consolidation 
##                 50                444               1307 
##        educational   home_improvement              house 
##                 15                152                 20 
##     major_purchase            medical             moving 
##                101                 30                 29 
##              other   renewable_energy     small_business 
##                199                  4                 87 
##           vacation            wedding 
##                 21                 39
```

```r
table(loansComplete$Employment.Length)
```

```
## 
##  < 1 year    1 year 10+ years   2 years   3 years   4 years   5 years 
##       248       177       653       244       235       192       202 
##   6 years   7 years   8 years   9 years       n/a 
##       163       127       108        72        77
```

```r
table(loansComplete$FICO.Range)
```

```
## 
## 640-644 645-649 650-654 655-659 660-664 665-669 670-674 675-679 680-684 
##       5       3       1       4     125     145     171     166     157 
## 685-689 690-694 695-699 700-704 705-709 710-714 715-719 720-724 725-729 
##     137     140     153     131     134     112      93     114      94 
## 730-734 735-739 740-744 745-749 750-754 755-759 760-764 765-769 770-774 
##      94      65      53      54      61      46      46      36      17 
## 775-779 780-784 785-789 790-794 795-799 800-804 805-809 810-814 815-819 
##      22      28      19      20      13      12      11       8       6 
## 820-824 830-834 
##       1       1
```



### Convert decriptive values to numeric

```r

loansFinal <- loansComplete

loansFinal$Interest.Rate <- as.numeric(sub("%", "", loansComplete$Interest.Rate))/100
loansFinal$Debt.To.Income.Ratio <- as.numeric(sub("%", "", loansComplete$Debt.To.Income.Ratio))/100
loansFinal$Loan.Length <- as.numeric(sub(" months", "", loansComplete$Loan.Length))

loansFinal$Employment.Length[loansFinal$Employment.Lenth == "n/a"] <- NA

loansFinal$Employment.Length <- as.numeric(sub(" years?", "", sub("10\\+ years", 
    "10", sub("< 1 year", "0", loansFinal$Employment.Length))))
```

```
## Warning: NAs introduced by coercion
```


### Convert Factors to indexed equivalents.

```r

loansFinal$FICO.Range <- sapply(strsplit(as.character(loansComplete$FICO.Range), 
    "-"), function(x) mean(as.numeric(x)))

levels(loansFinal$Loan.Purpose) <- 1:length(levels(loansFinal$Loan.Purpose))
loansFinal$Loan.Purpose <- as.numeric(loansFinal$Loan.Purpose)


levels(loansFinal$State) <- 1:length(levels(loansFinal$State))
loansFinal$State <- as.numeric(loansFinal$State)

levels(loansFinal$Home.Ownership) <- 1:length(levels(loansFinal$Home.Ownership))
loansFinal$Home.Ownership <- as.numeric(loansFinal$Home.Ownership)

loansFinall$loan
```

```
## Error: object 'loansFinall' not found
```



------

## Exploratory analysis

### Make some univariate plots/summaries


```r
hist(loansFinal$Interest.Rate, breaks = 100)
lines(density(loansFinal$Interest.Rate[loansFinal$Loan.Length == 36]), col = "red")
lines(density(loansFinal$Interest.Rate[loansFinal$Loan.Length == 60]), col = "blue")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-41.png) 

```r

quantile(loansFinal$Interest.Rate)
```

```
##     0%    25%    50%    75%   100% 
## 0.0542 0.1016 0.1311 0.1580 0.2489
```

```r
hist(loansFinal$FICO.Range, breaks = unique(loansFinal$FICO.Range))
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-42.png) 

```r
quantile(loansFinal$FICO.Range)
```

```
##   0%  25%  50%  75% 100% 
##  642  682  702  727  832
```

```r
hist(loansFinal$Employment.Length)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-43.png) 

```r
hist(loansFinal$Amount.Requested)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-44.png) 

```r
hist(loansFinal$Monthly.Income, breaks = 100)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-45.png) 

```r
hist(loansFinal$Revolving.CREDIT.Balance, breaks = 100)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-46.png) 

```r
hist(loansFinal$Revolving.CREDIT.Balance, breaks = 100)
```


### Make some univariate tables

```r
table(loansFinal$Employment.Length)
```

```
## 
##   0   1   2   3   4   5   6   7   8   9  10 
## 248 177 244 235 192 202 163 127 108  72 653
```

```r
table(loansFinal$Loan.Purpose)
```

```
## 
##    1    2    3    4    5    6    7    8    9   10   11   12   13   14 
##   50  444 1307   15  152   20  101   30   29  199    4   87   21   39
```

```r
table(loansFinal$State)
```

```
## 
##   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18 
##  11  38  13  46 433  61  50  11   8 169  98  12   1 101   3  21  23  22 
##  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36 
##  73  68  45  38  33   1   7  64  15  94  13  32 253  71  21  30  96  15 
##  37  38  39  40  41  42  43  44  45  46 
##  28   4 174  16  78   5  58  26  15   4
```

```r
table(loansFinal$Employment.Length)
```

```
## 
##   0   1   2   3   4   5   6   7   8   9  10 
## 248 177 244 235 192 202 163 127 108  72 653
```

```r
table(loansFinal$Loan.Purpose)
```

```
## 
##    1    2    3    4    5    6    7    8    9   10   11   12   13   14 
##   50  444 1307   15  152   20  101   30   29  199    4   87   21   39
```

```r
table(loansFinal$Home.Ownership)
```

```
## 
##    1    3    4    5 
## 1148    5  200 1145
```

```r

```



### IntrestRates vs FICO -> strong dependence

```r
boxplot(loansFinal$Interest.Rate ~ loansFinal$FICO.Range, varwidth = T)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 


### IntrestRates vs Loan length -> strong dependence

```r
boxplot(loansFinal$Interest.Rate ~ loansFinal$Loan.Length, varwidth = T)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 


### IntrestRates vs Ammount Requested

```r
boxplot(loansFinal$Interest.Rate ~ loansFinal$Amount.Requested, varwidth = T)
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 


### IntrestRates vs Employment Dur

```r
boxplot(loansFinal$Interest.Rate ~ loansFinal$Employment.Length, varwidth = T)
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 


### FICO vs Employment Dur

```r
boxplot(loansFinal$FICO.Range ~ loansFinal$Employment.Length, varwidth = T)
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 


### FICO vs Earnings

```r
boxplot(loansFinal$FICO.Range ~ loansFinal$Monthly.Income, varwidth = T)
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 


### FICO vs State

```r
boxplot(loansFinal$FICO.Range ~ loansFinal$State, varwidth = T)
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12.png) 


### IntrestRates vs Home Ownership

```r
boxplot(loansFinal$Interest.Rate ~ loansFinal$Home.Ownership, varwidth = T)
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13.png) 


### IntrestRates vs open credit lines

```r
boxplot(loansFinal$Interest.Rate ~ loansFinal$Open.CREDIT.Lines, varwidth = T)
```

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14.png) 


### IntrestRates vs revolving Credit Balance

```r
boxplot(loansFinal$Interest.Rate ~ loansFinal$Revolving.CREDIT.Balance, varwidth = T)
```

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-15.png) 


### IntrestRates vs inquiries

```r
boxplot(loansFinal$Interest.Rate ~ loansFinal$Inquiries.in.the.Last.6.Months, 
    varwidth = T)
```

![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-16.png) 


### IntrestRates vs loan  purpose -> medium dependence

```r
boxplot(loansFinal$Interest.Rate ~ loansFinal$Loan.Purpose, varwidth = T)
```

![plot of chunk unnamed-chunk-17](figure/unnamed-chunk-17.png) 


### IntrestRates vs debt to income

```r
boxplot(loansFinal$Interest.Rate ~ loansFinal$Debt.To.Income.Ratio, varwidth = T)
```

![plot of chunk unnamed-chunk-18](figure/unnamed-chunk-18.png) 




### try to find correlation for variables when FICO range is set constant 

```r


ficoLevels <- sort(unique(loansFinal$FICO.Range))
corrCoeff <- NULL

i <- 1

for (fico in ficoLevels) {
    
    loansFICO <- loansFinal[loansFinal$FICO.Range == fico, ]
    
    loansFICO$FICO.Range <- NULL
    
    corrCoeff <- cbind(corrCoeff, cor(loansFICO)[, "Interest.Rate"])
    
    i <- i + 1
}
```

```
## Warning: the standard deviation is zero
```

```
## Warning: the standard deviation is zero
```

```
## Warning: the standard deviation is zero
```

```
## Warning: the standard deviation is zero
```

```
## Warning: the standard deviation is zero
```

```r

colnames(corrCoeff) <- ficoLevels
```


### IntrestRates vs debt to income

```r
boxplot(loansFinal$Interest.Rate ~ loansFinal$Debt.To.Income.Ratio, varwidth = T)
```

![plot of chunk unnamed-chunk-20](figure/unnamed-chunk-20.png) 




### Plot the earthquakes on the globe/sized by relative depth

```r
map("world")
```

```
## Error: could not find function "map"
```

```r
points(quakesRaw$Lon, quakesRaw$Lat, pch = 19, col = "blue", cex = quakesRaw$Depth/max(quakesRaw$Depth))
```

```
## Error: object 'quakesRaw' not found
```



### Plot depth versus magnitude

```r
plot(quakesRaw$Depth, quakesRaw$Magnitude, pch = 19)
```

```
## Error: object 'quakesRaw' not found
```


### Looks weird, let's try a transform - need to add one to avoid log(0)

```r
summary(log10(quakesRaw$Depth), useNA = "ifany")
```

```
## Error: object 'quakesRaw' not found
```

```r
summary(log10(quakesRaw$Depth + 1))
```

```
## Error: object 'quakesRaw' not found
```

```r
quakesRaw$log10Depth <- log10(quakesRaw$Depth + 1)
```

```
## Error: object 'quakesRaw' not found
```


### Plot w/transform

```r
plot(quakesRaw$log10Depth, quakesRaw$Magnitude, pch = 19)
```

```
## Error: object 'quakesRaw' not found
```




### Color by Latitute 

```r
latCut = cut2(quakesRaw$Lat, g = 5)
```

```
## Error: could not find function "cut2"
```

```r
plot(quakesRaw$log10Depth, quakesRaw$Magnitude, pch = 19, col = latCut)
```

```
## Error: object 'quakesRaw' not found
```


Might be a lot of black in the top right quadrant

### Color by longitude 


```r
lonCut = cut2(quakesRaw$Lon, g = 5)
```

```
## Error: could not find function "cut2"
```

```r
plot(quakesRaw$log10Depth, quakesRaw$Magnitude, pch = 19, col = lonCut)
```

```
## Error: object 'quakesRaw' not found
```

Definitely a lot of light blue in the upper right hand quadrant


### Color by NST



```r
nstCut = cut2(quakesRaw$NST, g = 5)
```

```
## Error: could not find function "cut2"
```

```r
plot(quakesRaw$log10Depth, quakesRaw$Magnitude, pch = 19, col = nstCut)
```

```
## Error: object 'quakesRaw' not found
```



### Check out relationship with Src

```r
boxplot(quakesRaw$log10Depth ~ quakesRaw$Src)
```

```
## Error: object 'quakesRaw' not found
```

```r
boxplot(quakesRaw$Magnitude ~ quakesRaw$Src)
```

```
## Error: object 'quakesRaw' not found
```


### How do lat/lon correlated with source


```r

boxplot(quakesRaw$Lat ~ quakesRaw$Src)
```

```
## Error: object 'quakesRaw' not found
```

```r
boxplot(quakesRaw$Lon ~ quakesRaw$Src)
```

```
## Error: object 'quakesRaw' not found
```




### Get the formatted time, see earthquakes over time


```r
timeF = strptime(quakesRaw$Datetime, format = "%A, %B %e, %Y %H:%M:%S")
```

```
## Error: object 'quakesRaw' not found
```

```r
plot(timeF, quakesRaw$log10Depth)
```

```
## Error: object 'timeF' not found
```

```r
plot(timeF, quakesRaw$Magnitude)
```

```
## Error: object 'timeF' not found
```


------

## Modeling


## Fit a basic model relating depth to time


```r
lm1 <- lm(quakesRaw$Depth ~ quakesRaw$Magnitude)
```

```
## Error: object 'quakesRaw' not found
```

```r
summary(lm1)
```

```
## Error: object 'lm1' not found
```



## Plot the observed ('black') and fitted ('red') points


```r
lm1 <- lm(quakesRaw$Magnitude ~ quakesRaw$Depth)
```

```
## Error: object 'quakesRaw' not found
```

```r
plot(quakesRaw$Depth, quakesRaw$Magnitude, pch = 19)
```

```
## Error: object 'quakesRaw' not found
```

```r
points(quakesRaw$Depth, lm1$fitted, pch = 19, col = "red")
```

```
## Error: object 'quakesRaw' not found
```



## Look at residuals versus observations, residuals versus fitted values


```r
lm1 <- lm(quakesRaw$Magnitude ~ quakesRaw$Depth)
```

```
## Error: object 'quakesRaw' not found
```

```r
par(mfrow = c(1, 2))
plot(quakesRaw$Depth, lm1$residuals, pch = 19)
```

```
## Error: object 'quakesRaw' not found
```

```r
plot(lm1$fitted, lm1$residuals, pch = 19)
```

```
## Error: object 'lm1' not found
```


## Try the transform


```r
lm2 <- lm(quakesRaw$Magnitude ~ quakesRaw$log10Depth)
```

```
## Error: object 'quakesRaw' not found
```

```r
plot(quakesRaw$log10Depth, quakesRaw$Magnitude, pch = 19)
```

```
## Error: object 'quakesRaw' not found
```

```r
points(quakesRaw$log10Depth, lm2$fitted, pch = 19, col = "red")
```

```
## Error: object 'quakesRaw' not found
```



## Plot the residuals versus the observed and fitted (little better here)


```r
lm2 <- lm(quakesRaw$Magnitude ~ quakesRaw$log10Depth)
```

```
## Error: object 'quakesRaw' not found
```

```r
par(mfrow = c(1, 2))
plot(quakesRaw$log10Depth, lm2$residuals, pch = 19)
```

```
## Error: object 'quakesRaw' not found
```

```r
plot(lm2$fitted, lm2$residuals, pch = 19)
```

```
## Error: object 'lm2' not found
```


## What if we color residuals by lat (see a pattern)


```r
lm2 <- lm(quakesRaw$Magnitude ~ quakesRaw$log10Depth)
```

```
## Error: object 'quakesRaw' not found
```

```r
latCut = cut2(quakesRaw$Lat, g = 5)
```

```
## Error: could not find function "cut2"
```

```r
par(mfrow = c(1, 2))
plot(quakesRaw$log10Depth, lm2$residuals, pch = 19, col = latCut)
```

```
## Error: object 'quakesRaw' not found
```

```r
plot(lm2$fitted, lm2$residuals, pch = 19, col = latCut)
```

```
## Error: object 'lm2' not found
```



## What if we color residuals by lon (see a pattern)


```r
lm2 <- lm(quakesRaw$Magnitude ~ quakesRaw$log10Depth)
```

```
## Error: object 'quakesRaw' not found
```

```r
lonCut = cut2(quakesRaw$Lon, g = 5)
```

```
## Error: could not find function "cut2"
```

```r
par(mfrow = c(1, 2))
plot(quakesRaw$log10Depth, lm2$residuals, pch = 19, col = lonCut)
```

```
## Error: object 'quakesRaw' not found
```

```r
plot(lm2$fitted, lm2$residuals, pch = 19, col = lonCut)
```

```
## Error: object 'lm2' not found
```


## Now try fitting a new model with Lat in there


```r
latCut = cut2(quakesRaw$Lat, g = 5)
```

```
## Error: could not find function "cut2"
```

```r
lm3 <- lm(quakesRaw$Magnitude ~ quakesRaw$log10Depth + latCut)
```

```
## Error: object 'quakesRaw' not found
```

```r
par(mfrow = c(1, 2))
plot(quakesRaw$log10Depth, lm3$residuals, pch = 19, col = latCut)
```

```
## Error: object 'quakesRaw' not found
```

```r
plot(lm3$fitted, lm3$residuals, pch = 19, col = latCut)
```

```
## Error: object 'lm3' not found
```


## How about Lat/Lon


```r
latCut = cut2(quakesRaw$Lat, g = 5)
```

```
## Error: could not find function "cut2"
```

```r
lonCut = cut2(quakesRaw$Lon, g = 5)
```

```
## Error: could not find function "cut2"
```

```r
lm4 <- lm(quakesRaw$Magnitude ~ quakesRaw$log10Depth + latCut + lonCut)
```

```
## Error: object 'quakesRaw' not found
```

```r
par(mfrow = c(1, 2))
plot(quakesRaw$log10Depth, lm4$residuals, pch = 19, col = latCut)
```

```
## Error: object 'quakesRaw' not found
```

```r
plot(lm4$fitted, lm4$residuals, pch = 19, col = latCut)
```

```
## Error: object 'lm4' not found
```



## Color that model by NST


```r
latCut = cut2(quakesRaw$Lat, g = 5)
```

```
## Error: could not find function "cut2"
```

```r
lonCut = cut2(quakesRaw$Lon, g = 5)
```

```
## Error: could not find function "cut2"
```

```r
nstCut = cut2(quakesRaw$NST, g = 5)
```

```
## Error: could not find function "cut2"
```

```r
lm4 <- lm(quakesRaw$Magnitude ~ quakesRaw$log10Depth + latCut + lonCut)
```

```
## Error: object 'quakesRaw' not found
```

```r
par(mfrow = c(1, 2))
plot(quakesRaw$log10Depth, lm4$residuals, pch = 19, col = nstCut)
```

```
## Error: object 'quakesRaw' not found
```

```r
plot(lm4$fitted, lm4$residuals, pch = 19, col = nstCut)
```

```
## Error: object 'lm4' not found
```


## Include NST 


```r
latCut = cut2(quakesRaw$Lat, g = 5)
```

```
## Error: could not find function "cut2"
```

```r
lonCut = cut2(quakesRaw$Lon, g = 5)
```

```
## Error: could not find function "cut2"
```

```r
nstCut = cut2(quakesRaw$NST, g = 5)
```

```
## Error: could not find function "cut2"
```

```r
lm5 <- lm(quakesRaw$Magnitude ~ quakesRaw$log10Depth + latCut + lonCut + nstCut)
```

```
## Error: object 'quakesRaw' not found
```

```r
par(mfrow = c(1, 2))
plot(quakesRaw$log10Depth, lm5$residuals, pch = 19, col = nstCut)
```

```
## Error: object 'quakesRaw' not found
```

```r
plot(lm5$fitted, lm5$residuals, pch = 19, col = nstCut)
```

```
## Error: object 'lm5' not found
```




## Let's use model 5


```r
summary(lm5)
```

```
## Error: object 'lm5' not found
```

```r
confint(lm5)
```

```
## Error: object 'lm5' not found
```


## Let's plot fitted versus observed magnitudes on the map


```r
par(mfrow = c(2, 1))
map("world")
```

```
## Error: could not find function "map"
```

```r
lm5fitted <- lm5$fitted
```

```
## Error: object 'lm5' not found
```

```r
points(quakesRaw$Lon, quakesRaw$Lat, pch = 19, col = "blue", cex = lm5fitted/max(lm5fitted))
```

```
## Error: object 'quakesRaw' not found
```

```r
map("world")
```

```
## Error: could not find function "map"
```

```r
points(quakesRaw$Lon, quakesRaw$Lat, pch = 19, col = "blue", cex = quakesRaw$Magnitude/max(quakesRaw$Magnitude))
```

```
## Error: object 'quakesRaw' not found
```



