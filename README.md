### Assumptions
Before running the run_analysis.R script make sure the current directory is the directory where the *getdata-projectfiles-UCI HAR Dataset.zip* file has been unzipped. The script assumes the unzipping process preserved the directory structure of the zip file. In other words, the current directory has the following structure:

* [Train]
    + [Inertial Signals] - this folder is not used
    + X_train.txt
    + subject_train.txt
    + y_train.txt
* [Test]
    + [Inertial Signals] - this folder is not used
    + X_test.txt
    + y_test.txt
    + subject_test.txt
* README.txt
* features_info.txt
* features.txt
* activity_labels.txt


The following packages are required to run the script, and the script assumes they have already been installed on the current system:

* dplyr
* data.table
* reshape2

### The script

The script addresses the following requirements from the course projects:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subj


The script contains executes the following steps:

* It reads the list of fields in the features collection and it applies some name cleaning operations to satisfy requirement #4. 
```{r}
features <- read.table('features.txt')
names(features) <- c('Id', 'OriginalVariableName')

# The following block of code creates a new column in the features data frame that contains the variable names obtained after
# massaging the original variable names (got rid of the parentheses and converted to underscore anything that 
# was not letter or digit). It also expands some abbreviations to the log versions

features$VariableName <- gsub("_$", "", gsub("[^A-Za-z0-9]", "_", gsub("\\(\\)", "", features$OriginalVariableName) )) 
features$VariableName<-gsub("^t", "time", features$VariableName)
features$VariableName<-gsub("^f", "frequency", features$VariableName)
features$VariableName<-gsub("Acc", "Acceleration", features$VariableName)
features$VariableName<-gsub("Gyro", "Gyroscope", features$VariableName)
features$VariableName<-gsub("Mag", "Magnitude", features$VariableName)
features$VariableName<-gsub("BodyBody", "Body", features$VariableName)
features$VariableName<-gsub('Freq',"Frequency",features$VariableName)
features$VariableName<-gsub('\\_mean',"_Mean",features$VariableName)
features$VariableName<-gsub('\\_std',"_StandardDeviation",features$VariableName)
```
* Selects the columns that will be returned in the final dataset. Please note that the columns that contain the substrings mean or std are selected to comply with requirement #2.
```{r}
#Select the columns we want to ultimately return
selectedFeatures <- grepl("mean|std", features$OriginalVariableName)
```
* Reads the activity labels and associates column names to the data frame.
```{r}
activities <- read.table('activity_labels.txt')
names(activities) <- c('ActivityId', 'ActivityName')
```
* Defines a function that reads the raw data and it includes only the columns required based on requirment #2. The function also reads the files containing the subject ids and the activity ids, then it merges this data
into the final dataset. The activity ids are replaced with the activity names as per requirment #3
```{r}
#Define a function that takes the dataset type ('test' or 'train') and reads the dataset from the text file 
ReadData <- function (type)
{
        #Read the raw data
        rawData <- read.table(paste('./', type, '/', 'x_', type, '.txt', sep="")) 
        rawData <- rawData[, selectedFeatures]
        names(rawData) <- features[selectedFeatures,]$VariableName
        
        #Read the subject ids
        subjectIds <- read.table(paste('./', type, '/', 'subject_', type, '.txt', sep="")) 
        #add the subject ids to the raw data
        rawData$SubjectId <- subjectIds$V1
        #Read the activity ids
        activityIds <- read.table(paste('./', type, '/', 'y_', type, '.txt', sep="")) 
        names (activityIds) <- c('ActivityId')
        
        #add the activity names
        rawData$ActivityName <- inner_join(x=activityIds, y=activities)$ActivityName
        
        #return the value
        rawData
}
```
* The next block reads the datasets and combines them into one dataset as per requirement #1:
```{r}
#Read the data using the previously created function
trainData <- ReadData('train')
testData <- ReadData('test')

#Union the data in both tables
allData <- rbind(trainData, testData)
```
* The final block creates the final dataset that contains the averages of the selected variables, it writes to a file, and it prints it:
```{r}
#Create the dataset for the requirement at step 5 that computes the means of the columns by grouping the data by subject id and activity name
tds <- allData %>% group_by(SubjectId, ActivityName) %>% summarise_each_(funs(mean), head(names(allData), -2)) %>% arrange(SubjectId, ActivityName)

#Export the dataset to the txt file
write.table(tds, 'tds.txt', row.names=F)

#print the variable
print(tds)

tds
```


*Note*

Another option would have been to use the melt function and create a vertical oriented dataset. As an example (please note that the example doesn't preserver the measurement number that glues together the values on the same row):
```{r}
head(melt(allData, id = c("SubjectId", "ActivityName"), measure.vars = head(names(allData), - 3)), 10)
```

Which displays:
```
   SubjectId ActivityName                    variable     value
1          1     STANDING timeBodyAcceleration_Mean_X 0.2885845
2          1     STANDING timeBodyAcceleration_Mean_X 0.2784188
3          1     STANDING timeBodyAcceleration_Mean_X 0.2796531
4          1     STANDING timeBodyAcceleration_Mean_X 0.2791739
5          1     STANDING timeBodyAcceleration_Mean_X 0.2766288
6          1     STANDING timeBodyAcceleration_Mean_X 0.2771988
7          1     STANDING timeBodyAcceleration_Mean_X 0.2794539
8          1     STANDING timeBodyAcceleration_Mean_X 0.2774325
9          1     STANDING timeBodyAcceleration_Mean_X 0.2772934
10         1     STANDING timeBodyAcceleration_Mean_X 0.2805857
```

In this case the column names become values of the variable column. One can even go further an split the variable column into: signal (timeBodyAcceleration, timeGravityAcceleration etc.), operation (mean, std) and axis (x, y, z). I am not too sure what the benefits would be. 
