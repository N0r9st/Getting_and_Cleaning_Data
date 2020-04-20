# Getting_and_Cleaning_Data
## Explanation of the script
### Task 1. "Merges the training and the test sets to create one data set."
```{r}
x_test <- read.table("test/X_test.txt") ## reading test data
features <- read.table("features.txt")  ## reading and saving names of the variables
names(x_test)<-features[,2]             ## giving correct names to the data
y_test <- read.table("test/y_test.txt") 
subject_test <- read.table("test/subject_test.txt")
test <- cbind(subject=subject_test[[1]], activities = y_test[[1]], x_test) ## combining all of the test data
##=====================================================================
x_train <- read.table("train/X_train.txt") 
names(x_train)<-features[,2]             
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")
train <- cbind(subject=subject_train[[1]],  activities = y_train[[1]], x_train) ## combining all of the train data
##=====================================================================
all <- rbind(test,train) ## combining test and train data together
```
Script above collects all of the data, combines it and stores it in data frame named "all"
### Task 2. "Extracts only the measurements on the mean and standard deviation for each measurement."
```{r}
all <- all[,grepl("std|mean|subject|activities",names(all))]
```
Code line above completes task using function grepl() and subsetting
### Task 3. "Uses descriptive activity names to name the activities in the data set."
```{r}
all$activities <- as.factor(all$activities)
n_activities <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
levels(all$activities) <- n_activities
```
Activities was labeled with numbers in the raw data. I renamed them using factor variables.
### Task 4."Appropriately labels the data set with descriptive variable names."
Descriptive names are already given in the code chunk in Task 1 section.
Names was collected from "features.txt" and they was already considered decriprive.
Names "subject" and "activities" were assigned manually in the same chunk.
### Task 5. "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."
```{r}
library(dplyr)
bufer_names <- names(all)                       ## unnecessary column name manipulations
temp_names <- paste0("v",as.character(1:81))
names(all)<-temp_names
mean_all <- all %>% group_by(v1,v2) %>% summarise_all(mean)  ## getting our tidy data set
names(mean_all) <- bufer_names
```
In this chunk data was grouped by subjects and activities and then was summarised using summarise_all function.
You can see some manipulations with names of columns, but this manipulations was not necessary and was done to work with summarise function. You may ignore them.
