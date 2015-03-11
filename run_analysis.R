## Getting and Cleaning Data Course Project
library("data.table")
## This script does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Also, as required it can be run as long as the Samsung data is in your working directory.
## So first to make sure we have the data. If not we'll download it.
if(!file.exists("./project")) {dir.create("./project")}
if(!file.exists("./project/UCI HAR Dataset.zip")) {
    dataFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(dataFile, "project/UCI HAR Dataset.zip")
    unzip("project/UCI HAR Dataset.zip",junkpaths=T, exdir= "project/data")
}

## 1. Merges the training and the test sets to create one data set.==>mrg1
features1 <- read.table("./project/data/features.txt")
X_test1 <- read.table("./project/data/X_test.txt", col.names=features1[,2])
X_train1 <- read.table("./project/data/X_train.txt", col.names=features1[,2])
mrg1 <- rbind(X_test1, X_train1)
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. ==>tidy1
features2 <- features1[grep("(mean|std)\\(", features1[,2]),]
tidy1 <- mrg1[,features2[,1]]
## 3. Uses descriptive activity names to name the activities in the data set==>act1
y_test1 <- read.table("./project/data/y_test.txt", col.names = c("activity"))
y_train1 <- read.table("./project/data/y_train.txt", col.names = c("activity"))
act1 <- rbind(y_test1, y_train1)
## 4. Appropriately labels the data set with descriptive variable names. ==> LabeledX & LabeledMeanAndStd
labels <- read.table("./project/data/activity_labels.txt",col.names=c("num","label"))
labels$label <- as.character(labels$label)
for (i in 1:nrow(labels)) {
    act1[act1$activity == labels$num[i], ] <- labels$label[i]
}
LabeledX <- cbind(act1, mrg1)
LabeledMeanAndStd <- cbind(act1, tidy1)
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
##each variable for each activity and each subject.==> tidy2
subject_test1 <- read.table("./project/data/subject_test.txt", col.names = "subject")
subject_train1 <- read.table("./project/data/subject_train.txt", col.names = "subject")
subject1 <- rbind(subject_test1, subject_train1)
mrg3 <- as.data.table(cbind(subject1,LabeledX))
tidy2<-mrg3[, lapply(.SD, mean), by = c("subject", "activity")]
## creating a txt file to upload
write.table(tidy2, file='tidy2.txt', row.names=FALSE)

