x_test <- read.table("test/X_test.txt") ## reading data as df
features <- read.table("features.txt")  ## meaning of vector
names(x_test)<-features[,2]             ## giving appropriate names
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")
test <- cbind(subject=subject_test[[1]], activities = y_test[[1]], x_test) 
##=====================================================================
x_train <- read.table("train/X_train.txt") 
names(x_train)<-features[,2]             
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")
train <- cbind(subject=subject_train[[1]],  activities = y_train[[1]], x_train) 
##=====================================================================
all <- rbind(test,train)
all <- all[,grepl("std|mean|subject|activities",names(all))]
##=====================================================================
all$activities <- as.factor(all$activities)
n_activities <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
levels(all$activities) <- n_activities
##=====================================================================
library(dplyr)
bufer_names <- names(all)
temp_names <- paste0("v",as.character(1:81))
names(all)<-temp_names
mean_all <- all %>% group_by(v1,v2) %>% summarise_all(mean)
names(mean_all) <- bufer_names
mean_all