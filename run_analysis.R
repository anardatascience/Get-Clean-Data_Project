# Coursera : Getting and Cleaning Data Course Project
# Name: run_analysis.R
#
# Url for the Zip File : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# Working Directory: D:\Data Science\Working Directory
# Extracted Data Folder in the Working Directory: ./data/UCI_HAR_Dataset

# Include library <reshape2>
# reshape2 is an R package written by Hadley Wickham that makes it easy to transform data between wide and long formats.
# Key function that will be used in the scirpt are :
# melt  - takes wide-format data and melts it into long-format data.
# cast  - takes long-format data and casts it into wide-format data.
# Analogy: Think of working with metal: 
#          if you melt metal, it drips and becomes long. 
#          If you cast it into a mould, it becomes wide.
library(reshape2)

# Set the working directory 
setwd("D:/Data Science/Working Directory")

# Set the fileName 
fileName <- "getdata_Dataset.zip"
# Check if <data> directory exists
if(!file.exists("./data")) {dir.create("./data")}

setwd("./data")
getwd()

# Download and unzip file to the directory <UCI HAR Dataset>
if (!file.exists(fileName)){ 
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip " 
        download.file(fileURL,destfile= fileName,mode='wb') 
}   

if (!file.exists("UCI HAR Dataset")) {  
        unzip(fileName)  
        } 

# Load activity labels to a variable called  <ActivityLabels>
ActivityLabels <- read.table("UCI HAR Dataset/activity_labels.txt") 
ActivityLabels[,2] <- as.character(ActivityLabels[,2]) 

# Load features to a variable called  <Features>
Features <- read.table("UCI HAR Dataset/features.txt") 
Features[,2] <- as.character(Features[,2]) 

#Extracts only the measurements on the mean and standard deviation for each measurement.
#Using grep() to search for patterns like mean(*mean*)  & standard deviation(*std*) in the name
#Using gsub() since we need to make a Global relplacement
MeanStdfeatures <- grep("*mean*|*std*",Features[,2])
MeanStdfeatures.names <- Features[MeanStdfeatures,2]
MeanStdfeatures.names <- gsub('mean','Mean',MeanStdfeatures.names)
MeanStdfeatures.names <- gsub('std','StdDev',MeanStdfeatures.names)
MeanStdfeatures.names <- gsub('[()-]','',MeanStdfeatures.names)

#Load the training  data sets 
# 'train/X_train.txt': Training set.  Extract only the mean and standard deviation for each measurement
trainX <- read.table("UCI HAR Dataset/train/X_train.txt")[MeanStdfeatures]
# 'train/y_train.txt': Training Activities.
trainActivitiy <- read.table("UCI HAR Dataset/train/y_train.txt")
# 'train/subject_train.txt': Each row identifies the subject who performed the activity
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
# Combine the training data sets
# cbind() function combines vector, matrix or data frame by columns.
trainds <- cbind(trainX,trainActivitiy,trainSubjects)

#Load the test data sets 
# 'test/X_test.txt': test set. Extract only the mean and standard deviation for each measurement
testX <- read.table("UCI HAR Dataset/test/X_test.txt")[MeanStdfeatures]
# 'test/y_train.txt': Test Activities.
testActivity <- read.table("UCI HAR Dataset/test/y_test.txt")
# 'test/subject_test.txt': Each row identifies the subject who performed the activity
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
# Combine the test data sets
testds <- cbind(testX,testActivity,testSubjects)


# Merge the training and test data sets using rbind()
# rbind() function combines vector, matrix or data frame by rows.
completeDataDS <- rbind(trainds,testds)

# Add labels to the completeData data set
colnames(completeDataDS) <- c(MeanStdfeatures.names,"Activity","Subject")


# Convert the Activities and Subject into Factor
# The function factor is used to encode a vector as a factor 
completeDataDS$Activity <- factor(completeDataDS$Activity, levels = ActivityLabels[,1], labels = ActivityLabels[,2]) 

# as.factor coerces its argument to a factor. It is an abbreviated form of factor. 
completeDataDS$Subject <- as.factor(completeDataDS$Subject) 

# melt  - takes wide-format data and melts it into long-format data.
completeDataDS.melted <- melt(completeDataDS, id = c("Subject", "Activity")) 

# dcast  - takes long-format data and casts it into wide-format data.
completeDataDS.mean <- dcast(completeDataDS.melted, Subject + Activity ~ variable, mean) 


# create a second, independent tidy data set with the average of each variable for each activity and each subject.
#write.table prints its required argument x (after converting it to a data frame if it is not one nor a matrix) 
#to a file or connection. 
# The GetCleanDataTidy.csv is written to the Data Directory <Working Directory/data>
write.table(completeDataDS.mean, "GetCleanDataTidy.csv", col.names = TRUE, row.names = FALSE, sep = ",", dec = ".", quote = FALSE) 
