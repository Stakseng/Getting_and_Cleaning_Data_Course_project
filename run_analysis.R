##

library (reshape2)
library(data.table)

##Modify the path as needed.

path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")


## Read the labels for the different activities into a data frame, and give the columns names
df_ActivityLabels <- fread(file.path(path, "UCI HAR Dataset/activity_labels.txt"))
colnames(df_ActivityLabels) <- c("LabelsID", "NameofActivity")

## Read the labels for the different features into a data frame, and give the columns names
df_Features <- fread(file.path(path, "UCI HAR Dataset/features.txt"))
colnames(df_Features) <- c("index", "NameofFeature")

## Define the wanted features, based on search for specific parts of the names.
## The resulting array is the column numbers wanted from the measurements.
v_Wantedfeatures <- grep("(mean|std)\\(\\)", df_Features[, NameofFeature])

## Create a list with the names on the wanted features, based on the column numbers made in the previous step. 
v_Measurements <- df_Features[v_Wantedfeatures, NameofFeature]

## Remove some unneccesary letters.
v_Measurements <- gsub('[()]', '', v_Measurements)

## The three last operations can also be done in one, but then the code will be somewhat more difficult to read. 
##v_Measurements <- gsub('[()]', '' ,df_Features[grep("(mean|std)\\(\\)", df_Features[, NameofFeature]), NameofFeature])


## Load the training data values into a data frame, and only the wanted columns, and set then column names
df_training <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[, v_Wantedfeatures, with = FALSE]
data.table::setnames(df_training, colnames(df_training), v_Measurements)

## Load the ID's for the training activities into a data frame, and give the column a name
df_trainactivities <- fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt"), col.names = c("Activity"))

## Load the subjects for the training activities into a data frame, and give the column a name
df_trainsubjects <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt"), col.names = c("SubjectNumber"))

## Bind the three data frames together
df_training <- cbind(df_trainsubjects, df_trainactivities, df_training)

## Load the test data values into a data frame, and only the wanted columns, and set then column names
df_Test <- fread(file.path(path, "UCI HAR Dataset/test/X_test.txt"))[, v_Wantedfeatures, with = FALSE]
data.table::setnames(df_Test, colnames(df_Test), v_Measurements)

## Load the ID's for the test activities into a data frame, and give the column a name
df_TestActivities <- fread(file.path(path, "UCI HAR Dataset/test/Y_test.txt"), col.names = c("Activity"))

## Load the subjects for the test activities into a data frame, and give the column a name
df_testsubjects <- fread(file.path(path, "UCI HAR Dataset/test/subject_test.txt"), col.names = c("SubjectNumber"))

## Bind the three data frames together
df_Test <- cbind(df_testsubjects, df_TestActivities, df_Test)

## Bind together the test data set, and the training data set.
df_Combined <- rbind(df_training, df_Test)

## Change Activity, that is an id, to the corresponding label from df_ActivityLabels
## Make Activity and SubjectNumber factors, for use with reshape2.
df_Combined[["Activity"]] <- factor(df_Combined[, Activity], levels = df_ActivityLabels[["LabelsID"]], labels = df_ActivityLabels[["NameofActivity"]])
df_Combined[["SubjectNumber"]] <- as.factor(df_Combined[, SubjectNumber])

## Use reshape2 to melt, and then dcast to generate the mean for each Subject, Activity and Feature in the dataset.
df_Combined <- reshape2::melt(data = df_Combined, id = c("SubjectNumber", "Activity"))
df_Combined <- reshape2::dcast(data = df_Combined, SubjectNumber + Activity ~ variable, fun.aggregate = mean)

## Write the results to a textfile, that will contain the final tidy data set.
data.table::fwrite(x = df_Combined, file = "tidyData.txt", quote = FALSE)