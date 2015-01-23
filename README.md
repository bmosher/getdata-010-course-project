# Getting and Cleaning Data Course Project

## About the Data

This script requires the presence of data that can be obatined from the UCI Machine Learning Repository.  Informatino about the data set can be found at:

  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  
and the dataset can be downloaded from:

  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## About the Script

The run_analysis.R script does the following:

1.  Merges the training and test UCI HAR Datasets into a single data set (tidydata)
2.  Extracts the mean and standard devations from the data set created in the previous step
3.  Sets the value in the activity name column to the value found in "UCI HAR Dataset/activity_labels.txt"
4.  Sets the names of the columns for the data set to those provided in "UCI HAR Dataset/features.txt"
5.  Creates a second dataset (tidysummary) that contains the average of each mean and standard deviation for each activity and subject in the tidydata data set

An explanation of how each of these steps is accomplished can be found in the comments of run_analysis.R.

Details about the meanings of the values in the dataset can be found in "UCI HAR Dataset/features_info.txt".

## Running the Script

The data should be unzipped in the same directory as the run_analysis.R file.  A directory listing of the working directory should contain:
* run_analysis.R
* README.md
* UCI HAR Dataset
