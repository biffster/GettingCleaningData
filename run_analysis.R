library(dplyr)
library(plyr)

lookup= data.frame(activity=c(1,2,3,4,5,6),
                   activityname=c("Walking", "Walking upstairs","Walking downstairs","Sitting", "Standing", "Laying"))
  
# Read needed data from files into tables
vnames <- read.table("features.txt", header=FALSE)
trainxvalraw <- read.table("train/X_train.txt", header=FALSE)
trainyvalraw <- read.table("train/y_train.txt", header=FALSE)
testxvalraw <- read.table("test/X_test.txt", header=FALSE)
testyvalraw <- read.table("test/y_test.txt", header=FALSE)

# Set up constants
needcols <- c(1:6, 41:46, 81:86, 121:126)
colnames(trainyvalraw) <- "activity"
colnames(testyvalraw) <- "activity"

# Set up Activity field
trainydata <- join(trainyvalraw,lookup,by="activity")
trainydata <- trainydata[2]
testydata <- join(testyvalraw,lookup,by="activity")
testydata <- testydata[2]

# Merge the training data, activities to actual data
trainxdata <- trainxvalraw[,needcols]
traindata <- cbind(trainydata, trainxdata)

# Merge the training data, activities to actual data
testxdata <- testvalraw[,needcols]
testdata <- cbind(testydata, testxdata)

# Set up column names
newcolnames <- vnames[needcols,]
newcolnames <- rbind(data.frame(V1=0, V2 = "Activity"), newcolnames)
newcolnames <- as.character(newcolnames[,2])

# Merge column names
colnames(traindata) <- newcolnames
colnames(testdata) <- newcolnames

# Create the master merge data, ready to export
mergeddata <- rbind(traindata,testdata)

# Set up file connection and write the results to disk
zz <- file("output.txt", "w")
write.table(mergeddata, quote=FALSE, row.name=FALSE, sep="\t", file=zz)
close(zz)

MeanBodyAccelByActivity <- ddply(mergeddata,"Activity", summarize, "BodyAccelerationXAxisMean"=mean(BodyAccelerationXAxisMean),"BodyAccelerationYAxisMean"=mean(BodyAccelerationYAxisMean),"BodyAccelerationZAxisMean"=mean(BodyAccelerationZAxisMean))
MeanGravityAccelByActivity <- ddply(mergeddata,"Activity", summarize, "GravityAccelerationXAxisMean"=mean(GravityAccelerationXAxisMean),"GravityAccelerationYAxisMean"=mean(GravityAccelerationYAxisMean),"GravityAccelerationZAxisMean"=mean(GravityAccelerationZAxisMean))
MeanBodyJerkByActivity <- ddply(mergeddata,"Activity", summarize, "BodyJerkXAxisMean"=mean(BodyJerkXAxisMean),"BodyJerkYAxisMean"=mean(BodyJerkYAxisMean),"BodyJerkZAxisMean"=mean(BodyJerkZAxisMean))
MeanBodyGyroByActivity <- ddply(mergeddata,"Activity", summarize, "BodyGyroscopeXAxisMean"=mean(BodyGyroscopeXAxisMean),"BodyGyroscopeYAxisMean"=mean(BodyGyroscopeYAxisMean),"BodyGyroscopeZAxisMean"=mean(BodyGyroscopeZAxisMean))
