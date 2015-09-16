#####################################################################################################
## project Data Cleaning 
## read in data from Samsung Galaxy S2 
#####################################################################################################
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, 
#    independent tidy data set with the average of each variable for each activity and each subject.
#####################################################################################################
# List of things I need to submit: 
# > run_analysis R script, 
# > a ReadMe markdown document,
# > a Codebook markdown document, and 
# > a tidy data text file
#####################################################################################################

library("dplyr") 
library("data.table")

#### dataset location 
X_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", quote="\""); ## Training set 
y_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", quote="\""); ## Training labels 
X_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", quote="\""); ## Test set
y_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", quote="\""); ## Test labels 

## Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
subj_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"); 
##  same as above for test dataset 
subj_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt"); 

features <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt"); ## List of all features 
activities <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt"); ## Links the class labels with their activity name

#### rename column headings 
setnames(X_train, old = names(X_train), new = as.character(features[,2])); 
setnames(X_test, old = names(X_test), new = as.character(features[,2])); 
y_train <- rename(y_train, SubjectActivity = V1); 
y_test <- rename(y_test, SubjectActivity = V1); 
subj_train <- rename(subj_train,  Subject = V1);
subj_test <- rename(subj_test, Subject = V1); 

#### we need to change the naming in almost all headings 
## I opted out for the Java naming convention of a combination of Upper and Lower case letters
## to clearly separate the different words and 
## underscores to separate the numerical values, e.g. Energy Bands 
####

reName <- function(x){
    x <- sub("Acc", "Accelerometer", x);
    x <- sub("Gyro", "Gyroscope", x);
    x <- sub("BodyBody", "Body", x);
    x <- sub("tBody", "TimeBody", x); 
    x <- sub("tGravity", "TimeGravity", x); 
    x <- sub("fBody", "FrequencyBody", x);
    x <- sub("angle", "Angle", x);
    x <- sub("bands", "Bands", x);
    x <- sub("mad", "Median", x);
    x <- sub("mean", "Mean", x);
    x <- sub("std", "Std", x);
    x <- sub("arCoeff", "AutorRegresionCoefficient", x);
    x <- gsub("_", "", x);
    x <- gsub("-", "_", x);
    x <- gsub(",", "_", x);
    x <- gsub("\\(", "", x);
    x <- gsub("\\)", "", x);
}

names(X_train) <- lapply(names(X_train), reName);
names(X_test) <- lapply(names(X_test), reName);


#### merge training and test dataset and subject activity data 
ds_test <- cbind(subj_test, y_test, X_test);
ds_train <- cbind(subj_train, y_train, X_train); 
ActivityRecognitionDS <- rbind(ds_train, ds_test); 

#### remove duplicate columns 
## columns with EnergyBands are repeated 3 times (X,Y,Z)
ActivityRecognitionDS <- ActivityRecognitionDS[, !duplicated(colnames(ActivityRecognitionDS))] ; 

#### create a dplyr df 
ActivityRecognitionDF <- tbl_df(ActivityRecognitionDS); 

#### change Number-labels in SubjectActivity with the Name of the Activity from the 'activities' file 
rows.SubjActivity <- ActivityRecognitionDF$SubjectActivity ; 
ActivityRecognitionDF$SubjectActivity <- activities[,2][rows.SubjActivity]; 

#### extract mean and standard deviation (std) measurements 
## also keep the activity and activity subject info 
## give the mean (avg) for each mean or std column per subject and per subject activity 
MeanStdMeasurements <- 
    ActivityRecognitionDF %>% 
    select(1:2, matches(".[Mm]ean."), matches(".[Ss]td.")) %>%
    group_by(Subject, SubjectActivity) %>%
    summarise_each(funs(mean), -Subject, -SubjectActivity) ; 

## save the dataset in a text file 
write.table(MeanStdMeasurements, "MeanStdMeasurements.txt", sep = ",", row.names=F); 

