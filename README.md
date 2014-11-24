The dataset includes the following files:
=========================================

- 'README.md'

- 'CodeBookProjectWearable.txt': Code book

- 'run_analysis.R': R Script. See details below

- 'OutputOfRunAnalysis': Output of the R Script



Purpose of this R script is to read the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip (Since this is a one time task lines for reading and unzipping are commented). The script also prepares the data as per the following requirments of the assignment

1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis.R prepares the data for train and test independently before merging the two. Hence, I start taking care of the requirement 2 before I complete the requirement 1. Relevent comments are in script, I hope you find them useful.