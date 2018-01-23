## Get the the data if necessary ##
if (!file.exists('./data.zip')) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","data.zip")
  unzip("data.zip")
}

# retrieve train set, test set, general features, activity names and subject (all necessary for the code)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
Feature_names <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)[,2] #names of column
Activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt")
Train_subject<-read.table("./UCI HAR Dataset/train/subject_train.txt")
Test_subject<-read.table("./UCI HAR Dataset/test/subject_test.txt")


## 1) Merge training and test set to make one set of data ##
# X_Merge <- rbind(X_train,X_test)
# Y_Merge <- rbind(Y_train,Y_test)
# Subject_merge<-rbind(Train_subject,Test_subject)

data_set<-cbind(rbind(Train_subject,Test_subject),rbind(Y_train,Y_test),rbind(X_train,X_test))

## 2) Extracts only the measurements on the mean and standard deviation for each measurement.
feature_idx <- grep(("mean\\(\\)|std\\(\\)"), Feature_names)
Mean_Std_set <- data_set[, c(1, 2, feature_idx+2)]
colnames(Mean_Std_set) <- c("Subject", "Activity", Feature_names[feature_idx])

## 3)  Uses descriptive activity names to name the activities in the data set
#Mean_Std_set$activity <- factor(Mean_Std_set$activity, levels = Activity_names[,1], labels = Activity_names[,2])

## 4) appropriately labels the data set with descriptive variable names
names(Mean_Std_set) <- gsub("\\()", "", names(Mean_Std_set))
names(Mean_Std_set) <- gsub("^t", "time", names(Mean_Std_set))
names(Mean_Std_set) <- gsub("^f", "frequence", names(Mean_Std_set))
names(Mean_Std_set) <- gsub("-mean", "Mean", names(Mean_Std_set))
names(Mean_Std_set) <- gsub("-std", "Std", names(Mean_Std_set))

## 5) From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject
library(dplyr)
Tidy_finalSet <- Mean_Std_set %>% group_by(Subject, Activity) %>% summarise_all(.funs = c(mean="mean"))
write.table(Tidy_finalSet, "./TidySet.txt", row.names = FALSE)


