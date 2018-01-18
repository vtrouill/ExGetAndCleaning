## Get the the data if necessary ##
if (!file.exists('./data.zip')) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","data.zip")
  unzip("data.zip")
}

# retrieve train, test set and general feature
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
features <- read.table("./UCI HAR Dataset/features.txt")[,2] #names of column


## Merge training and test set to make one set of data ##

## Extracts only the measurements on the mean and standard deviation for each measurement.

## Uses descriptive activity names to name the activities in the data set
## appropriately labels the data set with descriptive variable names

## From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject