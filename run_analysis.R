## One time download and unzipping of the project data
##fileurl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##download.file(fileurl, destfile = "projectfiles.zip", mode="wb")
## unzip("projectfiles.zip")

#### Prepping training data ####
#Read in the X_train.txt
datxtrain <- read.table("UCIHARDataset/train/X_train.txt", header = FALSE) 

## There are 561 columns in X_train, one for each feature.
## First set of three columns are for mean and next set of three columns are for Std Deviation (per features.txt)
## So we will extract only 6 columns to satisfy the requirement number 2 of the assignmnet.
## I doing this here to reduce the size of the dataset in the memory to have improved performance
datxtrain_meanstd <- datxtrain[,1:6]

## Read Subject train data
datsubtrain <- read.table("UCIHARDataset/train/subject_train.txt", header = FALSE) 

## Read y_train.txt
datytrain <- read.table("UCIHARDataset/train/y_train.txt", header = FALSE) 

## cbind all the three datasets for test in the order xtrain, subject, ytrain
## They all have 7352 rows
dattrain <- cbind (datxtrain_meanstd, datsubtrain, datytrain) 


#### Now Prepping Test data so we can rbind with the above training data####
#Read in the X_test.txt
datxtest <- read.table("UCIHARDataset/test/X_test.txt", header = FALSE) 

## There are 561 columns in X_test, one for each feature.
## First set of three columns are for mean and next set of three columns are for Std Deviation (per features.txt)
## So we will extract only 6 columns to satisfy the requirement number 2 of the assignmnet.
## I am doing this here to reduce the size of the dataset in the memory to have improved performance
datxtest_meanstd <- datxtest[,1:6]

## Read Subject test data
datsubtest <- read.table("UCIHARDataset/test/subject_test.txt", header = FALSE) 

## Read y_test.txt
datytest <- read.table("UCIHARDataset/test/y_test.txt", header = FALSE) 

## cbind all the three datasets for test in the order xtest, subject, ytest
## They all have 2947 rows
dattest <- cbind (datxtest_meanstd, datsubtest, datytest ) 

## Merge the Train and Test Data. This satisfies requirment number 1
datall <- rbind(dattrain,dattest)

## Put descriptive heading to all the variables in order to satisfy requirement number 4
names(datall) <- c("tBodyAcc_mean_X","tBodyAcc_mean_Y","tBodyAcc_mean_Z", "tBodyAcc_std_X","tBodyAcc_std_Y","tBodyAcc_std_Z","Subject","ActvityCode")
# , "ActivityDecr")

## Last Column has the active code.
## Create a new column in datall and assign descriptive activity names based on activity_labels (kind of VLOOKUP )
## So now datall has code and its corresponding description. Later on, I will remove the code column 
datall$act_label <- "someactivityname"
datall$act_label[datall$ActvityCode == 1] <- "WALKING"
datall$act_label[datall$ActvityCode == 2] <- "WALKING_UPSTAIRS"
datall$act_label[datall$ActvityCode == 3] <- "WALKING_DOWNSTAIRS"
datall$act_label[datall$ActvityCode == 4] <- "SITTING"
datall$act_label[datall$ActvityCode == 5] <- "STANDING"
datall$act_label[datall$ActvityCode == 6] <- "LAYING"

## ActvityCode is redundant hence removing. 
datall$ActvityCode <- NULL

## At this point our data frame datall is ready for step 5
library(dplyr)
by_SubjectActivity <- group_by(datall, Subject, act_label)

datout <- summarize(by_SubjectActivity, 
	AverageOf_BodyAcc_mean_X=mean(tBodyAcc_mean_X),
	AverageOf_BodyAcc_mean_Y=mean(tBodyAcc_mean_Y),
	AverageOf_BodyAcc_mean_Z=mean(tBodyAcc_mean_Z),
	AverageOf_BodyAcc_std_X=mean(tBodyAcc_std_X),
	AverageOf_BodyAcc_std_Y=mean(tBodyAcc_std_Y),
	AverageOf_BodyAcc_std_Z=mean(tBodyAcc_std_Z)
)

dim(datout) 	
#datout is written to file OutputOfRunAnalysis.txt for uploading to github

write.table(datout, "OutputOfRunAnalysis.txt", sep="\t", row.names=FALSE) 
