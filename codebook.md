Original Datasets
-----------------

The original datas are retrieve from this url :
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
A full description is available at the site where the data was obtained
here:<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

### Overview

A group of 30 volunteers performed 6 different activities (WALKING,
WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) while
wearing a smartphone. Using its embedded accelerometer and gyroscope,
The smartphone captured various data about their movements.

### Files containing in the zip

-   *features.txt*: Names of the 561 features.
-   *activity\_labels.txt*: Names and IDs for each of the 6 activities
    (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING,
    LAYING).
-   *subject\_train.txt*: A vector of 7352 integers, denoting the ID of
    the volunteer related to each of the observations in X\_train.txt.
-   *X\_train.tx\_t*: 7352 observations of the 561 features, for 21 of
    the 30 volunteers.
-   *y\_train.txt*: A vector of 7352 integers, denoting the ID of the
    activity related to each of the observations in X\_train.txt.
-   *subject\_test.txt*: A vector of 2947 integers, denoting the ID of
    the volunteer related to each of the observations in X\_test.txt.
-   *X\_test.txt*: 2947 observations of the 561 features, for 9 of the
    30 volunteers.
-   *y\_test.txt*: A vector of 2947 integers, denoting the ID of the
    activity related to each of the observations in X\_test.txt.

-   *README.txt* : General informations file
-   *features\_info.tx* : More informations about the features.

-   all the files containing the raw datas and present in the Inertial
    Signals folders are not necessary for the present project and were
    not used.

\#\#\# retrieving the useful data

    X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
    Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
    X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
    Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
    Train_subject<-read.table("./UCI HAR Dataset/train/subject_train.txt")
    Test_subject<-read.table("./UCI HAR Dataset/test/subject_test.txt")

example of one file containing the subjects id

    ## 'data.frame':    2947 obs. of  1 variable:
    ##  $ V1: int  2 2 2 2 2 2 2 2 2 2 ...

example of one the file containing the activities id

    ## 'data.frame':    2947 obs. of  1 variable:
    ##  $ V1: int  5 5 5 5 5 5 5 5 5 5 ...

sample of one file containing the features value

    ##          V1          V2          V3         V4         V5
    ## 1 0.2571778 -0.02328523 -0.01465376 -0.9384040 -0.9200908
    ## 2 0.2860267 -0.01316336 -0.11908252 -0.9754147 -0.9674579
    ## 3 0.2754848 -0.02605042 -0.11815167 -0.9938190 -0.9699255
    ## 4 0.2702982 -0.03261387 -0.11752018 -0.9947428 -0.9732676
    ## 5 0.2748330 -0.02784779 -0.12952716 -0.9938525 -0.9674455

Merge training and test set to make one set of data
---------------------------------------------------

Bind the rows containing the subject (Train\_subject,Test\_subject)

Bind the rows containing the id of the activities related to the
observations (Y\_train,Y\_test)

Bind the rows containing the features (X\_train,X\_test)

Finaly bind the column together

    data_set<-cbind(rbind(Train_subject,Test_subject),rbind(Y_train,Y_test),rbind(X_train,X_test))

    ##   V1 V1.1      V1.2          V2         V3
    ## 1  1    5 0.2885845 -0.02029417 -0.1329051
    ## 2  1    5 0.2784188 -0.01641057 -0.1235202
    ## 3  1    5 0.2796531 -0.01946716 -0.1134617
    ## 4  1    5 0.2791739 -0.02620065 -0.1232826
    ## 5  1    5 0.2766288 -0.01656965 -0.1153619

After the merge the data set is made of 10299 obs. of 563 variables
(subject, activity and features)

Extracts only the measurements on the mean and standard deviation for each measurement.
---------------------------------------------------------------------------------------

    Feature <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)[,2]

    ##  chr [1:561] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" ...

    feature_idx <- grep(("mean\\(\\)|std\\(\\)"), Feature)
    Mean_Std_set <- data_set[, c(1, 2, feature_idx+2)]
    colnames(Mean_Std_set) <- c("Subject", "Activity", Feature[feature_idx])

The resulting data Mean\_Std\_se is a data frame of 10299 obs of 68
variables

Uses descriptive activity names to name the activities in the data set
----------------------------------------------------------------------

    Activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt")

    ##  chr [1:561] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" ...

    for (i in 1:6){
      Mean_Std_set$Activity[Mean_Std_set$Activity == i] <- as.character(Activity_names[i,2])
    }

    ##   Subject Activity timeBodyAccelerometerMean-X timeBodyAccelerometerMean-Y
    ## 1       1 STANDING                   0.2885845                 -0.02029417
    ## 2       1 STANDING                   0.2784188                 -0.01641057
    ## 3       1 STANDING                   0.2796531                 -0.01946716
    ## 4       1 STANDING                   0.2791739                 -0.02620065
    ## 5       1 STANDING                   0.2766288                 -0.01656965
    ##   timeBodyAccelerometerMean-Z
    ## 1                  -0.1329051
    ## 2                  -0.1235202
    ## 3                  -0.1134617
    ## 4                  -0.1232826
    ## 5                  -0.1153619

Appropriately labels the data set with descriptive variable names
-----------------------------------------------------------------

    names(Mean_Std_set) <- gsub("\\()", "", names(Mean_Std_set))
    names(Mean_Std_set) <- gsub("^t", "time", names(Mean_Std_set))
    names(Mean_Std_set) <- gsub("^f", "frequence", names(Mean_Std_set))
    names(Mean_Std_set) <- gsub("-mean", "Mean", names(Mean_Std_set))
    names(Mean_Std_set) <- gsub("-std", "Std", names(Mean_Std_set))
    names(Mean_Std_set) <- gsub("BodyBody", "Body", names(Mean_Std_set))

    ##   Subject Activity timeBodyAccelerometerMean-X timeBodyAccelerometerMean-Y
    ## 1       1 STANDING                   0.2885845                 -0.02029417
    ## 2       1 STANDING                   0.2784188                 -0.01641057
    ## 3       1 STANDING                   0.2796531                 -0.01946716
    ## 4       1 STANDING                   0.2791739                 -0.02620065
    ## 5       1 STANDING                   0.2766288                 -0.01656965
    ##   timeBodyAccelerometerMean-Z
    ## 1                  -0.1329051
    ## 2                  -0.1235202
    ## 3                  -0.1134617
    ## 4                  -0.1232826
    ## 5                  -0.1153619

From the data set in step 4, creates a second, independent tidy data set
------------------------------------------------------------------------

with the average of each variable for each activity and each subject
--------------------------------------------------------------------

    library(dplyr)
    Tidy_finalSet <- Mean_Std_set %>% group_by(Subject, Activity) %>% summarise_all(.funs = c(mean="mean"))

    ## # A tibble: 5 x 5
    ## # Groups: Subject [1]
    ##   Subject Activity  `timeBodyAccelero… `timeBodyAcceler… `timeBodyAcceler…
    ##     <int> <chr>                  <dbl>             <dbl>             <dbl>
    ## 1       1 LAYING                 0.222          -0.0405             -0.113
    ## 2       1 SITTING                0.261          -0.00131            -0.105
    ## 3       1 STANDING               0.279          -0.0161             -0.111
    ## 4       1 WALKING                0.277          -0.0174             -0.111
    ## 5       1 WALKING_…              0.289          -0.00992            -0.108

    write.table(Tidy_finalSet, "./TidySet.txt", row.names = FALSE)
