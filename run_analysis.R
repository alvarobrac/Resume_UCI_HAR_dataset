# Download and unzip dataset in my working directory
fileUrl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileUrl, destfile = "./UCI_HAR_Dataset.zip")
unzip("./UCI_HAR_Dataset.zip")

library(data.table)
library(dplyr)

# Read X Train, 7352 rows x 561 columns
# Each column has a length of 16 position (widths = rep(16,561))
# Reduced size buffer to prevent memory problems (buffersize = 10)
X_train = read.fwf("./UCI HAR Dataset/train/X_train.txt", widths = rep(16,561) , strip.white = TRUE, buffersize = 10)
# Read X Test, 2947 rows x 561 columns
# Each column has a length of 16 position (widths = rep(16,561))
# Reduced size buffer to prevent memory problems (buffersize = 10)
X_test = read.fwf("./UCI HAR Dataset/test/X_test.txt", widths = rep(16,561) , strip.white = TRUE, buffersize = 10)
# Union training and test datasets to create one dataset.
# 10299 rows x 561 columns
X = rbind(X_train,X_test)
# Convert in data.table
X = data.table(X)
rm("X_train","X_test")

# Read y Train (activity_train), 7352 rows x 1 columns
y_train = read.table("./UCI HAR Dataset/train/y_train.txt", sep = " ", stringsAsFactors = FALSE)
# Read y Test (activity_test), 2947 rows x 1 columns
y_test = read.table("./UCI HAR Dataset/test/y_test.txt", sep = " ", stringsAsFactors = FALSE)
# Union training and test activity datasets to create one activity dataset
activity = rbind(y_train,y_test)
# Read activity labels. 6 rows x 2 columns
activity_labels = read.table("./UCI HAR Dataset/activity_labels.txt", sep = " ")
# Convert in data.table
activity = data.table(activity)
activity_labels = data.table(activity_labels)
# Define key to merge
setkey(activity,V1)
setkey(activity_labels,V1)
# Merges activity and activity_labels dataset and filter for the column with descriptive activity names
# 10299 rows x 1 columns
activity_t = merge(activity, activity_labels)[,V2]

# Read Subject Train. 7352 rows x 1 columns
subject_train = read.table("./UCI HAR Dataset/train/subject_train.txt", sep = " ", stringsAsFactors = FALSE)
# Read Subject Test. 2947 rows x 1 columns
subject_test = read.table("./UCI HAR Dataset/test/subject_test.txt", sep = " ", stringsAsFactors = FALSE)
# Union subject training and subject test datasets to create one dataset.
# 10299 rows x 1 columns
subject = rbind(subject_train,subject_test)

# Read Features (number and column names) = 561 rows x 2 columns
features = read.table("./UCI HAR Dataset/features.txt", sep = " ", stringsAsFactors = FALSE)

# Set names to dataset
names(X) <- features[,2]

FIL = X %>%
# Used grep (regular expresion) to choose those fields (names(X)) containing 
# the string mean() or std () (with special character sets \\)
  select(grep("mean\\(\\)|std\\(\\)",names(X))) %>%
#2. DONE (Extracts only the measurements on the mean and standard deviation for each measurement)
  mutate(activity=activity_t,subject=subject)
#1. DONE (Merges the training and the test sets to create one data set)
#4. DONE (Appropriately labels the data set with descriptive variable names)
#3. DONE (Uses descriptive activity names to name the activities in the data set

# Rename labels
names(FIL) <- gsub("[)(-]","",names(FIL))

rm("activity","activity_labels","features","subject","subject_test","subject_train","y_test","y_train","activity_t","X")

# Easy to work!! Print concatenate string "mean(labels)" for each label of dataset
paste("mean(",names(select(FIL,1:66)),")",sep="", collapse= ",")

new = FIL %>%
# Group by activity and subject
  group_by(activity,subject) %>%
# Easy to work!!. Copy and paste the above string
  summarise(mean(tBodyAccmeanX),mean(tBodyAccmeanY),mean(tBodyAccmeanZ),mean(tBodyAccstdX),mean(tBodyAccstdY),mean(tBodyAccstdZ),mean(tGravityAccmeanX),mean(tGravityAccmeanY),mean(tGravityAccmeanZ),mean(tGravityAccstdX),mean(tGravityAccstdY),mean(tGravityAccstdZ),mean(tBodyAccJerkmeanX),mean(tBodyAccJerkmeanY),mean(tBodyAccJerkmeanZ),mean(tBodyAccJerkstdX),mean(tBodyAccJerkstdY),mean(tBodyAccJerkstdZ),mean(tBodyGyromeanX),mean(tBodyGyromeanY),mean(tBodyGyromeanZ),mean(tBodyGyrostdX),mean(tBodyGyrostdY),mean(tBodyGyrostdZ),mean(tBodyGyroJerkmeanX),mean(tBodyGyroJerkmeanY),mean(tBodyGyroJerkmeanZ),mean(tBodyGyroJerkstdX),mean(tBodyGyroJerkstdY),mean(tBodyGyroJerkstdZ),mean(tBodyAccMagmean),mean(tBodyAccMagstd),mean(tGravityAccMagmean),mean(tGravityAccMagstd),mean(tBodyAccJerkMagmean),mean(tBodyAccJerkMagstd),mean(tBodyGyroMagmean),mean(tBodyGyroMagstd),mean(tBodyGyroJerkMagmean),mean(tBodyGyroJerkMagstd),mean(fBodyAccmeanX),mean(fBodyAccmeanY),mean(fBodyAccmeanZ),mean(fBodyAccstdX),mean(fBodyAccstdY),mean(fBodyAccstdZ),mean(fBodyAccJerkmeanX),mean(fBodyAccJerkmeanY),mean(fBodyAccJerkmeanZ),mean(fBodyAccJerkstdX),mean(fBodyAccJerkstdY),mean(fBodyAccJerkstdZ),mean(fBodyGyromeanX),mean(fBodyGyromeanY),mean(fBodyGyromeanZ),mean(fBodyGyrostdX),mean(fBodyGyrostdY),mean(fBodyGyrostdZ),mean(fBodyAccMagmean),mean(fBodyAccMagstd),mean(fBodyBodyAccJerkMagmean),mean(fBodyBodyAccJerkMagstd),mean(fBodyBodyGyroMagmean),mean(fBodyBodyGyroMagstd),mean(fBodyBodyGyroJerkMagmean),mean(fBodyBodyGyroJerkMagstd))
#5. DONE (From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject)

write.table(new,"new_dataset.txt", row.names = FALSE)