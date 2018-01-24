## Getting and Cleaning Data Course Project

The purpose of this project is to create R script that does the following :
  1) Merges the training and the test sets to create one data set
  2) Extracts only the measurements on the mean and standard deviation for each measurement.
  3) Uses descriptive activity names to name the activities in the data set
  4) propriately labels the data set with descriptive variable names.
  5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Original Data Set

Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

### Steps 

Just source("run_analysis.R") and it will download the datas and  will generate a new file TidySet.txt in your working directory. At the end, a codebook in .md is generated from codebook.rmd present in the directory.

### Dependencies

it depends on the library dplyr.
