library(dplyr)
## download file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","./dataset.zip")

## get the 6 files in R variables
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, as.is = TRUE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, as.is = TRUE)
subject_test <-read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, as.is = TRUE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, as.is = TRUE)
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, as.is = TRUE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, as.is = TRUE)

## combine the test values into one variable
x_test_full <- mutate(measure = 0, contestant = 0, x_test)
x_test_full$measure = y_test$V1
x_test_full$contestant = subject_test$V1

## combine the train values into one variable
x_train_full <- mutate(measure = 0, contestant = 0, x_train)
x_train_full$measure = y_train$V1
x_train_full$contestant = subject_train$V1

## combine the train and test into one variable - since columns are same
x_all <- rbind(x_train_full,x_test_full)

## read the features file to get the labels
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, as.is = TRUE)
features[562,2] <- "measure"
features[563,2] <- "contestantnumber"

## assign the labels to the main variable
names(x_all) <- features[,2]
## get the required mean/std columns only
x_needed <- x_all[, c(1,2,3,4,5,6,41, 42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543,562,563)]

## get the file with the measurement labels
measurename <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE, as.is = TRUE)
names(measurename) <- c("measure","activityname")

## merge the main file and the measurement name into one
x_needed_name <- merge(x_needed, measurename, by.x = "measure", by.y = "measure", all= FALSE, incomparables = NULL)
x_needed_name <- x_needed_name[,2:69]
## make the labels meaningful
names(x_needed_name) <- c("BodyAccMeanforX","BodyAccMeanforY","BodyAccMeanforZ","BodyAccStdforX","BodyAccStdforY","BodyAccStdforZ","GravityAccMeanforX","GravityAccMeanforY","GravityAccMeanforZ","GravityAccStdforX","GravityAccStdforY","GravityAccStdforZ","BodyAccJerkMeanforX","BodyAccJerkMeanforY","BodyAccJerkMeanforZ","BodyAccJerkStdforX","BodyAccJerkStdforY","BodyAccJerkStdforZ","BodyGyroMeanforX","BodyGyroMeanforY","BodyGyroMeanforZ","BodyGyroStdforX","BodyGyroStdforY","BodyGyroStdforZ","BodyGyroJerkMeanforX","BodyGyroJerkMeanforY","BodyGyroJerkMeanforZ","BodyGyroJerkStdforX","BodyGyroJerkStdforY","BodyGyroJerkStdforZ","BodyAccMagMean","BodyAccMagStd","GravityAccMagMean","GravityAccMagStd","BodyAccJerkMagMean","BodyAccJerkMagStd","BodyGyroMagMean","BodyGyroMagStd","BodyGyroJerkMagMean","BodyGyroJerkMagStd","fBodyAccMeanforX","fBodyAccMeanforY","fBodyAccMeanforZ","fBodyAccStdforX","fBodyAccStdforY","fBodyAccStdforZ","fBodyAccJerkMeanforX","fBodyAccJerkMeanforY","fBodyAccJerkMeanforZ","fBodyAccJerkStdforX","fBodyAccJerkStdforY","fBodyAccJerkStdforZ","fBodyGyroMeanforX","fBodyGyroMeanforY","fBodyGyroMeanforZ","fBodyGyroStdforX","fBodyGyroStdforY","fBodyGyroStdforZ","fBodyAccMagMean","fBodyAccMagStd","BodyBodyAccJerkMagMean","BodyBodyAccJerkMagStd","BodyBodyGyroMagMean","BodyBodyGyroMagStd","BodyBodyGyroJerkMagMean","BodyBodyGyroJerkMagStd","ContestantNumber","ActivityName")

## group by based on contestant and activity name
sum_x <- group_by(x_needed_name, ContestantNumber,ActivityName)
## summarize all other columns
final <- summarize_each(sum_x, funs(mean))

## write into an external file
write.table(final, file = "./FinalTidyDataset.txt", row.names = FALSE)