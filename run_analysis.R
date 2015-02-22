library(plyr)

#
# Merges the training and the test sets to create one data set.
#

# read train data
trainDataX <- read.table("./train/X_train.txt")
trainDataY <- read.table("./train/Y_train.txt")
trainDataSubject <- read.table("./train/subject_train.txt")

# read test data
testDataX <- read.table("./test/X_test.txt")
testDataY <- read.table("./test/Y_test.txt")
testDataSubject <- read.table("./test/subject_test.txt")

# merge train and test data
dataX <- rbind(trainDataX, testDataX)
dataY <- rbind(trainDataY, testDataY)
dataSubject <- rbind(trainDataSubject, testDataSubject)

#
# Extracts only the measurements on the mean and standard deviation for each measurement.
#

# read features
features <- read.table("./features.txt")

# find features for mean and standard deviation
subFeatures <- features[str_detect(string = features[, 2], pattern = "mean\\(\\)|std\\(\\)"),]

# extract subset features for origin data 
subDataX <- dataX[,subFeatures[,1]]

# assign column names
colnames(subDataX) <- subFeatures[,2]

# Uses descriptive activity names to name the activities in the data set
activityLabel <- read.table("./activity_labels.txt")

# by join data Y and activity label, get the activity name for each Y value
activityDes <- join(dataY, activityLabel, type = "inner", match = "all")

# assign activity name back to data Y
dataY <- activityDes[, 2, drop=F]

# name column Y
names(dataY) <- "activity"

#
# Appropriately labels the data set with descriptive variable names.
#

# substitute t to time, f to frequency
names(subDataX) <- gsub("^t", "Time", names(subDataX))
names(subDataX) <- gsub("^f", "Frequency", names(subDataX))

#
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#

# name column subject
names(dataSubject) <- "subject"

# bind all data
data <- cbind(subDataX, dataY, dataSubject)

# create tidy data, by using ddply, compute mean for all columns except for last two (column activity and subject)
averageData <- ddply(data, .(activity, subject), function(x) colMeans(x[, -c(ncol(x)-1, ncol(x))]))

# write data out
write.table(averageData, "./finalData.txt", row.name=FALSE)
