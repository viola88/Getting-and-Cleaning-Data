# Just used in my case, change the working directory appropriately
#setwd("D:/Documents/Einarbeitung/Coursera/UCI HAR Dataset")

# Read the Files
y_test <- read.table("test/y_test.txt")
X_test <- read.table("test/X_test.txt")
subject_test <- read.table("test/subject_test.txt")
y_train <- read.table("train/y_train.txt")
X_train <- read.table("train/X_train.txt")
subject_train <- read.table("train/subject_train.txt")

# Merge training and test sets to create one data set
X <- rbind(X_train,X_test)
y <- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test)
colnames(subject) <- c("TestPerson")
colnames(y) <- c("Activity")
dataset <- cbind(subject,y,X)

# Extract measurements on mean and standard deviation for each measurement
features <- read.table("features.txt")
extractidx <- grep("mean\\(|std\\(",features$V2)
features$V2[extractidx]
X <- X[,extractidx]
dataset <- cbind(subject,y,X) # update dateset

# Use descriptive activity names to name the activities in the data set
activitylabels <- c("WALKING", "WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
dataset$Activity <- factor(dataset$Activity,labels=activitylabels)

# Appropriately label the data set with descriptive variable names
# Here I use the names from the feature file
temp <- NULL
for (j in 1:66){
  temp <- cbind(temp, toString(features[extractidx[j],2]))
}
colnames(dataset) <- cbind("Person","Activity",temp)

# Create independent tidy data set with average of each variable for each activity and each subject
dataclone <<- dataset
dataclone <- aggregate(dataclone[,3:68],by=list(dataclone$Person,dataclone$Activity), FUN = mean)
colnames(dataclone) <- cbind("Person","Activity",temp)

# Save results in .txt file
write.table(dataclone,"result.txt",col.names=TRUE, row.name=FALSE)
