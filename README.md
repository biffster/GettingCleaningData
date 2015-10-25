# Getting and cleaning data - class project
Michael Fierro (mifierro@cisco.com, Signature track)<br>October 25, 2015

## Project Assumptions
- I made a few assumptions and personifications for this class project. I will list these here:
- Personification:
  - I only pulled out the first four groups of columns from the original dataset. This is enough data to prove that my script works and provides accurate tidy data; any more than this for a class project seems extraneous.
  - For Step 5 in the class project definition, I decided to output one file for each set of data. This choice was made assuming that future researchers may want only a subset of the data available. Providing separate files seems to be a tidier format for the data. The files are:
    1. BodyAccel.txt
    2. BodyGyro.txt
    3. BodyJerk.txt
    4. GravityAccel.txt

- Assumptions
  - Paths will be set up as they are on my system. Assuming that the data set archive was extracted into R's working directory, the paths would be:
    - features.txt in the working directory
    - test/ contains the test data files
    - train/ contains the train data files
    - all output is written to the working directory

  - The following libraries need to be loaded:
    - library(dplyr)
    - library(plyr)

## Project Workflow
1. Create data tables from the data set text files:  
  - vnames <- read.table("features.txt", header=FALSE)
   trainxvalraw <- read.table("train/X_train.txt", header=FALSE)
  - trainyvalraw <- read.table("train/y_train.txt", header=FALSE)
  - testxvalraw <- read.table("test/X_test.txt", header=FALSE)
  - testyvalraw <- read.table("test/y_test.txt", header=FALSE)
2. Set up constant values used during the script's run
  - needcols <- c(1:6, 41:46, 81:86, 121:126), the columns that will be processed
  - colnames(trainyvalraw) <- "activity", the column name for the Activity field
3. Set up lookup table and use this to get the column names
  - colnames <-  join(testyvalraw,lookup,by="activity")
4. Merge column names
  - colnames(data) <- newcolnames
5. Merge activities onto the data
  - data <- cbind(trainydata, trainxdata)
6. Create the master merge data, ready to export
  - mergeddata <- rbind(traindata,testdata)
7. Write out the master merge file (fierro.txt)
  - write.table(mergeddata, row.name=FALSE)
8.  Step 5 from the class project assignment: calculate the mean of each column per each activity per each subject.
9. Write those dataframes to disk

## Variables in the tidy dataset:
### Global variable to label the type of activity being measured
- Activity                      : factor
- Variables related to the Body Acceleration measurements
- BodyAccelerationXAxisMean     : num
- BodyAccelerationYAxisMean     : num
- BodyAccelerationZAxisMean     : num
- BodyAccelerationXAxisstddev   : num
- BodyAccelerationYAxisstddev   : num
- BodyAccelerationZAxisstddev   : num
- BodyAccelByActivity - data.frame containing the mean of each measurement for the Body Acceleration measurements

### Variables related to the Body Acceleration measurements
- GravityAccelerationXAxisMean  : num
- GravityAccelerationYAxisMean  : num
- GravityAccelerationZAxisMean  : num
- GravityAccelerationXAxisstddev: num
- GravityAccelerationYAxisstddev: num
- GravityAccelerationZAxisstddev: num
- GravityAccelByActivity - data.frame containing the mean of each measurement for the Gravity Acceleration measurements

### Variables related to the Body Acceleration measurements
- BodyJerkXAxisMean             : num
- BodyJerkYAxisMean             : num
- BodyJerkZAxisMean             : num
- BodyJerkXAxisstddev           : num
- BodyJerkYAxisstddev           : num
- BodyJerkZAxisstddev           : num
- BodyJerkByActivity - data.frame containing the mean of each measurement for the Body Jerk measurements

### Variables related to the Body Acceleration measurements
- BodyGyroscopeXAxisMean        : num
- BodyGyroscopeYAxisMean        : num
- BodyGyroscopeZAxisMean        : num
- BodyGyroscopeXAxisstddev      : num
- BodyGyroscopeYAxisstddev      : num
- BodyGyroscopeZAxisstddev      : num
- MeanBodyGyroByActivity - data.frame containing the mean of each measurement for the Body Gyroscope measurements

## Filenames:
### Provided from dataset:
- features.txt
- train/X_train.txt
- train/y_train.txt
- test/X_test.txt
- test/y_test.txt

### Generated via run_analysis.R
- fierro.txt - Merged Data
- BodyAccel.txt - BodyAccelByActivity written to text
- GravityAccel.txt - GravityAccelByActivity written to text
- BodyJerk.txt - BodyJerkByActivity written to text
- BodyGyro.txt - MeanBodyGyroByActivity written to text
