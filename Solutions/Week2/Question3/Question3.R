download.file("https://dl.dropbox.com/u/7710864/data/csv_hid/ss06hid.csv", destfile = "data.csv")

download.file("https://spark-public.s3.amazonaws.com/dataanalysis/PUMSDataDict06.pdf", destfile = "codebook.pdf")

data <- read.csv("data.csv")

nrow(data[data$VAL == 24 & data$TYPE == 1 & !is.na(data$VAL) ,c("VAL","TYPE")])

# q5
nrow(data[data$BDS == 3 & data$RMS == 4 & data$TYPE == 1 ,c("VAL","TYPE")])
nrow(data[data$BDS == 2 & data$RMS == 5 & data$TYPE == 1 ,c("VAL","TYPE")])

# q6
agricultureLogical <- data$ACR == 3 & data$AGS == 6 & data$TYPE == 1

# q7
indexes <- which(agricultureLogical)

subsetDataFrame  = data[indexes,] 

length(which(is.na(subsetDataFrame$MRGX)))

# q8

proccesedNames <- strsplit(names(data),"wgtp")

proccesedNames[123]

# q9

quantile(data$YBL[data$YBL >=1 & data$YBL <=9], na.rm = T,)

# q10

download.file("https://dl.dropbox.com/u/7710864/data/csv_hid/ss06pid.csv", destfile = "data2.csv")

housingData <- data

populationData <- read.csv("data2.csv")

mergedData <- merge(housingData,populationData, by = "SERIALNO")
