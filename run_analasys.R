## This script reads in test and training data and formats into two tidy 
##     data sets.
##   tidydata    - contains the means and standard deviations from each 
##                 sample
##   tidysummary - contains the averages of the tidydata for each activity 
##                 and subject


## This is the directory we expect to find inside of the working directory
## that contains the data
directory <- "UCI HAR Dataset"

## getDataset reads data from a directory inside of 'directory',
##   it gives us the ability to specify which data we want to read
##   which is the type of data we want (train or test)
getDataset <- function(which) {
  # we read each file in the directory, X_which.txt, y_which.txt, and
  #   subject_which.txt
  x <- read.table(paste(directory, "/", which, "/X_", which, ".txt", sep=""))
  activity <- read.table(paste(directory, "/", which, "/y_", which, ".txt", sep=""))
  subject <- read.table(paste(directory, "/", which, "/subject_", which, ".txt", sep=""))
  # then we bind them together
  data <- cbind(subject, activity, x)
  # and return the result
  return(data)
}

## getLabels reads the column labels for the train and test data sets
##   and formats them to be usable in R
getLabels <- function() {
  # the column labels are read from features.txt
  features <- read.table(paste(directory, "/features.txt", sep=""), stringsAsFactors=FALSE)
  # the actual names are in the second column of the data read
  row_names <- features[,2]
  # now we need to remove parentheses and dashes, we replace them with 
  # underscores this gives us column names that are usable in R
  for (i in seq(1, length(row_names))) {
    # for each row_name replace the value with one that we can use
    row_names[i] <- gsub("[\\(\\)]", "", row_names[i])
    row_names[i] <- gsub("[],\\-]", "_", row_names[i])
  }
  # now we add the subject and activity names to the features
  row_names <- c('subject', 'activity', row_names)
  # and return the complete set of labels
  return(row_names)
}

## loadActivityLabels read the names of the Activities and their
##   corresponding numerical value from activity_labels.txt
loadActivityLabels <- function() {
  # we first read the data
  activity_labels <- read.table(paste(directory, "/activity_labels.txt", sep=""), stringsAsFactors=FALSE)
  # then return it
  return(activity_labels)
}

## getDescriptiveActivityLabel returns the descriptive activity for a 
##   given numeric value, this allows us to use mutate to set the descriptive
##   values
getDescriptiveActivityLabel <- function(number, activity_labels) {
  # return the index given as number from activity_labels
  return(activity_labels[number,2])
}

# bind all rows from the test and train datasets using the
#   getDataset function defined above
data <- rbind(getDataset("test"), getDataset("train"))
# set the names of the columns to the ones read using getLabels
names(data) <- getLabels()

# here we decide which columsn to keep, we want the means and
#   standard deviations, but not meanFreq.  To do this we include
#   colunns with names that contain "mean_", "std_", or names that 
#   end in "mean" or "std"
keep_cols <- sort(c(1, 2, grep("mean_", names(data)), grep("mean$", names(data)), grep("std_", names(data)), grep("std$", names(data))))
# then we set tidydata to the selected columns
tidydata <- data[,keep_cols]

# now we load the labels for the activities
activity_labels <- loadActivityLabels()
# and set the activity column values to be the descriptive name
#   for the activity that the previous numeric value identified
tidydata <- mutate(tidydata, activity = getDescriptiveActivityLabel(activity, activity_labels))

# create a second data set that is grouped by suject and activity
tidysummary <- group_by(tidydata, subject, activity)
# so that we can summarize the data with the mean of each of the data columns
tidysummary <- summarize(tidysummary,
                         mean(tBodyAcc_mean_X),    
                         mean(tBodyAcc_mean_Y),    
                         mean(tBodyAcc_mean_Z),    
                         mean(tBodyAcc_std_X),    
                         mean(tBodyAcc_std_Y),    
                         mean(tBodyAcc_std_Z),    
                         mean(tGravityAcc_mean_X),    
                         mean(tGravityAcc_mean_Y),    
                         mean(tGravityAcc_mean_Z),    
                         mean(tGravityAcc_std_X),    
                         mean(tGravityAcc_std_Y),    
                         mean(tGravityAcc_std_Z),    
                         mean(tBodyAccJerk_mean_X),    
                         mean(tBodyAccJerk_mean_Y),    
                         mean(tBodyAccJerk_mean_Z),    
                         mean(tBodyAccJerk_std_X),    
                         mean(tBodyAccJerk_std_Y),    
                         mean(tBodyAccJerk_std_Z),    
                         mean(tBodyGyro_mean_X),    
                         mean(tBodyGyro_mean_Y),    
                         mean(tBodyGyro_mean_Z),    
                         mean(tBodyGyro_std_X),    
                         mean(tBodyGyro_std_Y),    
                         mean(tBodyGyro_std_Z),    
                         mean(tBodyGyroJerk_mean_X),    
                         mean(tBodyGyroJerk_mean_Y),    
                         mean(tBodyGyroJerk_mean_Z),    
                         mean(tBodyGyroJerk_std_X),    
                         mean(tBodyGyroJerk_std_Y),    
                         mean(tBodyGyroJerk_std_Z),    
                         mean(tBodyAccMag_mean),    
                         mean(tBodyAccMag_std),    
                         mean(tGravityAccMag_mean),    
                         mean(tGravityAccMag_std),    
                         mean(tBodyAccJerkMag_mean),    
                         mean(tBodyAccJerkMag_std),    
                         mean(tBodyGyroMag_mean),    
                         mean(tBodyGyroMag_std),    
                         mean(tBodyGyroJerkMag_mean),    
                         mean(tBodyGyroJerkMag_std),    
                         mean(fBodyAcc_mean_X),    
                         mean(fBodyAcc_mean_Y),    
                         mean(fBodyAcc_mean_Z),    
                         mean(fBodyAcc_std_X),    
                         mean(fBodyAcc_std_Y),    
                         mean(fBodyAcc_std_Z),    
                         mean(fBodyAccJerk_mean_X),    
                         mean(fBodyAccJerk_mean_Y),    
                         mean(fBodyAccJerk_mean_Z),    
                         mean(fBodyAccJerk_std_X),    
                         mean(fBodyAccJerk_std_Y),    
                         mean(fBodyAccJerk_std_Z),    
                         mean(fBodyGyro_mean_X),    
                         mean(fBodyGyro_mean_Y),    
                         mean(fBodyGyro_mean_Z),    
                         mean(fBodyGyro_std_X),    
                         mean(fBodyGyro_std_Y),    
                         mean(fBodyGyro_std_Z),    
                         mean(fBodyAccMag_mean),    
                         mean(fBodyAccMag_std),    
                         mean(fBodyBodyAccJerkMag_mean),    
                         mean(fBodyBodyAccJerkMag_std),    
                         mean(fBodyBodyGyroMag_mean),    
                         mean(fBodyBodyGyroMag_std),    
                         mean(fBodyBodyGyroJerkMag_mean),    
                         mean(fBodyBodyGyroJerkMag_std)
               )