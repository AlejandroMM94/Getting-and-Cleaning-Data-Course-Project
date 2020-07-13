# Setup working directory
setwd("C:/Users/S510U/Desktop")
getwd()

# Download files
library(data.table)
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
  download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
  unzip("UCI HAR Dataset.zip", exdir = getwd())
}

# Read the Data
# Read Features file and save it as a character vector
column_names <- read.table('./UCI HAR Dataset/features.txt')
column_names <- as.character(column_names[,2])

# Read Train files
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
activities_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Create a Train data.frame with the three files 
database_train <- data.frame(subject_train, activities_train, X_train)

# Rename the columns of the Train data.frame using the column_names vector and the names subject and activity
names(database_train) <- c(c("subject", "activity"), column_names)

# Read Test files
features_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
activities_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Create a Test data.frame with the three files
database_test <- data.frame(subject_test, activities_test, features_test)

# Rename the columns of the Train data.frame using the column_names vector and the names subject and activity
names(database_test) <- c(c("subject", "activity"), column_names)

# Merge both databases
merged_database <- rbind(database_train, database_test)

# Extract measurements on the mean and standard deviation for each measurement.
subdatabase <- (merged_database[, c(grep("mean|std", column_names) + 2)])

# Use descriptive activity names to name the activities in the data set
activity_names <- read.table('./UCI HAR Dataset/activity_labels.txt')
activity_names <- as.character(activity_names[,2])
merged_database$activity <- activity_names[merged_database$activity]

# Label the data set with descriptive variable names.
name <- names(merged_database)
name <- gsub("^t", "Time_", name)
name <- gsub("^f", "Frequency_", name)
name <- gsub("^a", "A", name)
name <- gsub("^s", "S", name)
name <- gsub("Body", "Body_", name)
name <- gsub("Gravity", "Gravity_", name)
name <- gsub("Acc", "Accelerometer_", name)
name <- gsub("Gyro", "Gyroscope_", name)
name <- gsub("Jerk", "Jerk_", name)
name <- gsub("Mag", "Magnitude_", name)
name <- gsub("[(][)]", "", name)
name <- gsub("[-]", "", name)
name <- gsub("mean", "Mean", name)
name <- gsub("std", "Standard_deviation", name)
name <- gsub("mad", "Median_absolute_deviation", name)
name <- gsub("max", "Maximum", name)
name <- gsub("min", "Minimum", name)
name <- gsub("sma", "Signal_Magnitude", name)
name <- gsub("energy", "Energy_Measure", name)
name <- gsub("iqr", "Interquartile_range", name)
name <- gsub("entropy", "Entropy_energy", name)
name <- gsub("arCoeff", "Autorregresion_Coefficients", name)
name <- gsub("correlation", "Correlation_Coefficients", name)
name <- gsub("maxInds", "Maximum_Index", name)
name <- gsub("meanFreq", "Mean_Frequency", name)
name <- gsub("skewness", "Skewness", name)
name <- gsub("kurtosis", "Kurtosis", name)
name <- gsub("bandsEnergy", "FFT_Energy", name)
name <- gsub("X", "_X", name)
name <- gsub("Y", "_Y", name)
name <- gsub("Z", "_Z", name)
names(merged_database) <- name

# Create a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data <- aggregate(merged_database[,3:563], by = list(Subject = merged_database$Subject, Activity = merged_database$Activity),FUN = mean)
write.table(tidy_data, "tidy_data_set.txt", row.names = FALSE)
