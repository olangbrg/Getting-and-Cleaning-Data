# Getting and Cleaning Data
## Course project

This script does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Also, as required it can be run as long as the Samsung data is in your working directory.
So first to make sure we have the data. If not we'll download it.
The next step (1) merges the training and the test sets to create one data set, creating the data.frame: mrg1.

Step 2 extracts only the measurements on the mean and standard deviation for each measurement, creating the data.frame: tidy1.

Step 3 uses descriptive activity names to name the activities in the data set, creating the data.frame: act1

Step 4 appropriately labels the data set with descriptive variable names, creating two 
data.frames: LabeledX & LabeledMeanAndStd

Step 5 then from the data set in step 4, creates a second, independent tidy data set with the average of 
each variable for each activity and each subject, creating the last data.frame: tidy2

The final step creates a txt file to upload.

