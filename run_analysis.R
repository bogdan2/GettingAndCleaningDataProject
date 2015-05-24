
#required packages
require("data.table")
require("reshape2")
require("plyr")
#Let's read the input data

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

#Select the columns we want to ultimately return
selectedFeatures <- grepl("mean|std", features$OriginalVariableName)


activities <- read.table('activity_labels.txt')
names(activities) <- c('ActivityId', 'ActivityName')

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

#Read the data using the previously created function
trainData <- ReadData('train')
testData <- ReadData('test')

#Union the data in both tables
allData <- rbind(trainData, testData)

#Create the dataset for the requirement at step 5 that computes the means of the columns by grouping the data by subject id and activity name
tds <- allData %>% group_by(SubjectId, ActivityName) %>% summarise_each_(funs(mean), head(names(allData), -2)) %>% arrange(SubjectId, ActivityName)

#Export the dataset to the txt file
write.table(tds, 'tds.txt', row.names=F)

#print the variable
print(tds)

tds

