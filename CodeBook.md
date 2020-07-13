# CodeBook

This CodeBook describes the variables, the data, and the transformations that were performed to clean up the data.

## Data Source 

Raw Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Used Files

"./UCI HAR Dataset/features.txt" = List of all features, this file was used to name the columns of the database

"./UCI HAR Dataset/train/X_train.txt" = Training set, this file contained the measurements of the 561 variables calculated by the accelerometer and gyroscope of the smartphone
od the Train group

"./UCI HAR Dataset/train/y_train.txt" = Each row identifies the 6 physical activities measured in each window sample of the Train group. Its range is from 1 to 6

"./UCI HAR Dataset/train/subject_train.txt" = Each row identifies the subject who performed the activity for each window sample of the Train group. Its range is from 1 to 30

"./UCI HAR Dataset/test/X_test.txt" = Training set, this file contained the measurements of the 561 variables calculated by the accelerometer and gyroscope of the smartphone
od the Test group

"./UCI HAR Dataset/test/y_test.txt" = Each row identifies the 6 physical activities measured in each window sample of the Test group. Its range is from 1 to 6

"./UCI HAR Dataset/test/subject_test.txt" = Each row identifies the subject who performed the activity for each window sample of the Test group. Its range is from 1 to 30

"./UCI HAR Dataset/activity_labels.txt" = List of all physical activities, this file was used to name the rows of the second column of the database merged

## Script

The run_ analysis.R file does the following:

_ Load the 8 files mentioned above

_ Merges the training and the test sets to create one data set called merged_database

_ Extracts the measurements on the mean and standard deviation for each measurement and create a data set called subdatabase

_ Uses the activity_labels.txt file names to name the activities in the data set

_ Labels the data set with descriptive variable names using the information of the features_info.txt file and the function gsub()

_ Creates a second, independent tidy data set with the average of each variable for each activity and each subject. This tidy data is called tidy_data

## Output File
"./tidy_data_set.txt", wtih 180 observations of 563 variables. 

