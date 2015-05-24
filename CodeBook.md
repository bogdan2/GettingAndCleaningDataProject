# Code Book

The dataset described in this document results from applying the run_analysis.R script to the data contained in this [dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). Before proceeding to the list included in this file, it is useful to review the original data. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

For convenience, I included the information available in the features_info.txt file:

```
Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
```

As per the project requirement, the dataset produced by the run_analysis.R script includes the columns corresponding to measurements on the mean and standard deviation of each measurement. The abbreviations contained in the column names have been expanded to full words.

The columns are:

* **SubjectId** - number, with values between 1 and 30, each number corresponding to a human subject that was part of the experiment.
* **Activity** - all the possible values are:

|Activity           
|-------------------
|WALKING                                    
|WALKING_UPSTAIRS   
|WALKING_DOWNSTAIRS 
|SITTING            
|STANDING           
|LAYING             

* **timeBodyAcceleration_Mean_X**
* **timeBodyAcceleration_Mean_Y**
* **timeBodyAcceleration_Mean_Z**
* **timeBodyAcceleration_StandardDeviation_X**
* **timeBodyAcceleration_StandardDeviation_Y**
* **timeBodyAcceleration_StandardDeviation_Z**
* **timeGravityAcceleration_Mean_X**
* **timeGravityAcceleration_Mean_Y**
* **timeGravityAcceleration_Mean_Z**
* **timeGravityAcceleration_StandardDeviation_X**
* **timeGravityAcceleration_StandardDeviation_Y**
* **timeGravityAcceleration_StandardDeviation_Z**
* **timeBodyAccelerationJerk_Mean_X**
* **timeBodyAccelerationJerk_Mean_Y**
* **timeBodyAccelerationJerk_Mean_Z**
* **timeBodyAccelerationJerk_StandardDeviation_X**
* **timeBodyAccelerationJerk_StandardDeviation_Y**
* **timeBodyAccelerationJerk_StandardDeviation_Z**
* **timeBodyGyroscope_Mean_X**
* **timeBodyGyroscope_Mean_Y**
* **timeBodyGyroscope_Mean_Z**
* **timeBodyGyroscope_StandardDeviation_X**
* **timeBodyGyroscope_StandardDeviation_Y**
* **timeBodyGyroscope_StandardDeviation_Z**
* **timeBodyGyroscopeJerk_Mean_X**
* **timeBodyGyroscopeJerk_Mean_Y**
* **timeBodyGyroscopeJerk_Mean_Z**
* **timeBodyGyroscopeJerk_StandardDeviation_X**
* **timeBodyGyroscopeJerk_StandardDeviation_Y**
* **timeBodyGyroscopeJerk_StandardDeviation_Z**
* **timeBodyAccelerationMagnitude_Mean**
* **timeBodyAccelerationMagnitude_StandardDeviation**
* **timeGravityAccelerationMagnitude_Mean**
* **timeGravityAccelerationMagnitude_StandardDeviation**
* **timeBodyAccelerationJerkMagnitude_Mean**
* **timeBodyAccelerationJerkMagnitude_StandardDeviation**
* **timeBodyGyroscopeMagnitude_Mean**
* **timeBodyGyroscopeMagnitude_StandardDeviation**
* **timeBodyGyroscopeJerkMagnitude_Mean**
* **timeBodyGyroscopeJerkMagnitude_StandardDeviation**
* **frequencyBodyAcceleration_Mean_X**
* **frequencyBodyAcceleration_Mean_Y**
* **frequencyBodyAcceleration_Mean_Z**
* **frequencyBodyAcceleration_StandardDeviation_X**
* **frequencyBodyAcceleration_StandardDeviation_Y**
* **frequencyBodyAcceleration_StandardDeviation_Z**
* **frequencyBodyAcceleration_MeanFrequency_X**
* **frequencyBodyAcceleration_MeanFrequency_Y**
* **frequencyBodyAcceleration_MeanFrequency_Z**
* **frequencyBodyAccelerationJerk_Mean_X**
* **frequencyBodyAccelerationJerk_Mean_Y**
* **frequencyBodyAccelerationJerk_Mean_Z**
* **frequencyBodyAccelerationJerk_StandardDeviation_X**
* **frequencyBodyAccelerationJerk_StandardDeviation_Y**
* **frequencyBodyAccelerationJerk_StandardDeviation_Z**
* **frequencyBodyAccelerationJerk_MeanFrequency_X**
* **frequencyBodyAccelerationJerk_MeanFrequency_Y**
* **frequencyBodyAccelerationJerk_MeanFrequency_Z**
* **frequencyBodyGyroscope_Mean_X**
* **frequencyBodyGyroscope_Mean_Y**
* **frequencyBodyGyroscope_Mean_Z**
* **frequencyBodyGyroscope_StandardDeviation_X**
* **frequencyBodyGyroscope_StandardDeviation_Y**
* **frequencyBodyGyroscope_StandardDeviation_Z**
* **frequencyBodyGyroscope_MeanFrequency_X**
* **frequencyBodyGyroscope_MeanFrequency_Y**
* **frequencyBodyGyroscope_MeanFrequency_Z**
* **frequencyBodyAccelerationMagnitude_Mean**
* **frequencyBodyAccelerationMagnitude_StandardDeviation**
* **frequencyBodyAccelerationMagnitude_MeanFrequency**
* **frequencyBodyAccelerationJerkMagnitude_Mean**
* **frequencyBodyAccelerationJerkMagnitude_StandardDeviation**
* **frequencyBodyAccelerationJerkMagnitude_MeanFrequency**
* **frequencyBodyGyroscopeMagnitude_Mean**
* **frequencyBodyGyroscopeMagnitude_StandardDeviation**
* **frequencyBodyGyroscopeMagnitude_MeanFrequency**
* **frequencyBodyGyroscopeJerkMagnitude_Mean**
* **frequencyBodyGyroscopeJerkMagnitude_StandardDeviation**
* **frequencyBodyGyroscopeJerkMagnitude_MeanFrequency**



