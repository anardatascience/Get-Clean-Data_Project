# Get-Clean-Data_Project
# Course project for Getting And Cleaning Data Course project from Coursera.
# Script: run_analysis.R

The Script run_analysis.R performs the following steps:

1. Download the data file from the following link onto the Working Directory/data:
   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Extract the zip file to a directory called <UCI HAR Dataset>
3. Load Data:
      3.1.  Load activity labels to a variable called  <ActivityLabels>
      3.2   Load features to a variable called  <Features>
4. Extract only the measurements on the mean and standard deviation for each measurement.
      4.1   Use grep() & gsub()
5. Load the Training data sets & combine to a single data set
      5.1   'train/X_train.txt': Training set.  Extract only the mean and standard deviation for each measurement
      5.2   'train/y_train.txt': Training Activities.
      5.3   'train/subject_train.txt': Each row identifies the subject who performed the activity
      5.4   Combine the train data sets using cbind()
6. Load the Test data sets & combine to a single data set
      6.1   'test/X_test.txt': test set. Extract only the mean and standard deviation for each measurement
      6.2   'test/y_train.txt': Test Activities.
      6.3   'test/subject_test.txt': Each row identifies the subject who performed the activity
      6.4   Combine the test data sets using cbind()
7. Merge the training and test data sets using rbind()
8. Add labels to the completeData data set
9. Convert the Activities and Subject into Factor using the factor() function for Activity and as.factor for Subject
10. Use the melt(). Melt takes wide-format data and melts it into long-format data.
11. Use the dcast(). dcast takes long-format data and casts it into wide-format data.
12. Use write.table(). create a second, independent tidy data (.csv) set with the average of each variable for each activity and each subject. 

