# Resume_UCI_HAR_dataset

I have created one R script called [run_analysis.R][run_analysis.R] that does the following:
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Script: [run_analysis.R][run_analysis.R]

Output: [new_dataset.txt][new_dataset.txt]

Codebook: [CodeBook.md][CodeBook.md]

Then I detail the steps followed in the script:

1. First, download and unzip dataset in my working directory.
2. Read X_train, X_test files and merge both in a dataset (X).
3. Read y_train, y_test files and merge both in a dataset (activity).
4. Read activity_labes files in a dataset.
5. Merge activity and activity_labels to uses descriptive activity names to name the activities in the data set.
6. Read subject_train, subject_test files and merge both in a dataset (subjet).
7. Read Features files in a dataset. Rename labels (names(X)) the data set with descriptibe variable names (subject)
8. Extrac only th meassurements on the mean and standard deviation for each measurement (Expression Regular in labels)
9. Add subject and activity in the dataset(X)
10. Group by activity,subject and summarize with mean of each labels
11. Write table in new_dataset.txt file

For more detail, see the script file [run_analysis.R][run_analysis.R] and Code Book file [CodeBook.md][CodeBook.md]

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

[run_analysis.R]: run_analysis.R
[new_dataset.txt]: new_dataset.txt
[CodeBook.md]: CodeBook.md
