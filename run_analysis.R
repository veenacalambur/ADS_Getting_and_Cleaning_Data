#### Load in Libraries #### 
library(dplyr)
library(tidyr)


#### Set WD #### 

setwd("~/Data Science Training/Getting and Cleaning Data/Week 4/")

#### Read in Data #### 

## Download and unzip the dataset from URL ## 

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "UCI HAR Dataset Folder.zip")

unzip("UCI HAR Dataset Folder.zip") 

## Change WD and read in all files ## 

setwd("UCI HAR Dataset")

activity_labels = read.table("activity_labels.txt", header = F)
features = read.table("features.txt")


xtrain = read.table("train/X_train.txt")
ytrain = read.table("train/y_train.txt")
subject_train = read.table("train/subject_train.txt")

xtest = read.table("test/X_test.txt")
ytest = read.table("test/y_test.txt")
subject_test = read.table("test/subject_test.txt")

#### Work on formatting for Train / Test Data #### 


#### Process X data set #### 

## row bind the x, y, and subject data sets into single DFs ## 

x = rbind(xtrain, xtest)

#### Extract Mean and SD features #### 

## grep for mean() or std() in feature names ## 
mean_sd_features_list = grep("mean\\(\\)|std\\(\\)", features$V2)
mean_sd_features_names =as.character(features$V2[mean_sd_features_list])

# clean up names # 
mean_sd_features_names = gsub("\\(\\)", "", gsub("-", "_", mean_sd_features_names))

## grab those corresponding columns in the X data frame and rename the variables in X to the feature names 
x_mean_std = x[,mean_sd_features_list]
names(x_mean_std) = mean_sd_features_names

#### Process Y data set #### 

y = rbind(ytrain, ytest)

## Add Activity Labels to Y ## 

y <- y%>%
  dplyr:: left_join(activity_labels, by = "V1")%>%
  dplyr:: select(-V1) ## remove the Activity ID

names(y) = c("Activity")

#### Process Subject Data set #### 
subject = rbind(subject_train, subject_test)

names(subject) = c("Subject_ID")

#### Combine X, Y, and Subject #### 

activity_df = cbind(subject,y,x_mean_std)

#### create mini data set of averages of each variable #### 

activity_df_avg = activity_df%>%
  dplyr:: group_by(Subject_ID, Activity)%>%
  dplyr:: summarise_each_(funs(mean(., na.rm = T)),mean_sd_features_names) # this line helps me process the 
 
write.table(activity_df_avg, )

