---
title: "CodeBook"
author: "Alexandre Huynen"
date: "1/23/2017"
output: html_document
---

# Human Activity Recognition Using Smartphones Data Set

## Introduction

This repository is hosting the ```R``` code for the assignment of the Data Science track's "Getting and Cleaning Data" course. 

The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. In other words, the goal is to prepare tidy data that can be used for later analysis.

## Data Set

These abilities are demonstrated on the **Human Activity Recognition Using Smartphones Data Set (HRA)** available at the UCI [Website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

>#### Data Set Information:
>
>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
>
>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
>
> #### Attribute Information:
>
>For each record in the dataset it is provided: 
>
>* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
>* Triaxial Angular velocity from the gyroscope. 
>* A 561-feature vector with time and frequency domain variables. 
>* Its activity label. 
>* An identifier of the subject who carried out the experiment.

#### Input data files

The following data files were used:

* ```activity_labels.txt``` links the class labels with their activity name.
* ```features.txt``` lists all features, and is used to identify the dataset data columns.
* ```test/subject_test.txt``` identifies the subject that performed the test activity for each window sample.
* ```test/X_test.txt``` contains the test dataset.
* ```test/y_test.txt``` contains the test dataset labels, used to identify the activity performed for each window sample. 
* ```train/subject_train.txt``` identifies the subject that performed the training activity for each window sample.
* ```train/X_train.txt``` contains the training dataset.
* ```train/y_train.txt``` contains the training dataset labels, used to identify the activity performed for each window sample. 

Note that the text files contained in the directories ```test/Inertial Signals``` and ```train/Inertial Signals``` are ignored here.

## Raw data processing and tidying

This section describes the variables, the data, and the script ```run_analysis.R``` ([link]()) that processes and tidies the data set.

The script flow is as follows:

1. The requiered libraries/packages are loaded.
2. If not already present in the current (sub-) directory, the raw data set is loaded and unzipped.
3. The text files are read and their content stored.
4. The training and the test data sets are merged to create one data set.
5. The measurements on the mean and standard deviation for each measurement are extracted.
6. Descriptive activity names are used to name the activities in the data set
7. The data set is appropriately labeled with descriptive variable names.
8. From the data set in step 7, a second, independent tidy data set is created with the average of each variable for each activity and each subject.
9. Finally, this tidy data set is exported in the text file ```tidydata.txt```.

For more information about this script, please refer to the [README.md]() file.

## Variables

The output data set is exported in the text file ```tidydata.txt```. The header line contains the names of the variables. It contains the following variables:

##### Factor
1. "subject": factor with levels ranging from 1 to 30. The identifier of the study subject.
2. "activity": factor with levels in (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) corresponding to the physical activity in which the subject is engaged.

#### Time domain variables
Numeric variables corresponding to observations/meassurements in time domain. They were obtained from the accelerometer (**Accelerometer**) and gyroscope (**Gyroscope**) 3-axial signals (**X-Y-Z**) with the acceleration signal separated into body (**BodyAccelerometer**) and gravity acceleration (**GravityAccelerometer**) signals. The Jerk (**Jerk**) and magnitude (**Magnitude**) signals are also given. The suffixes **mean** and **std** refer to the mean value and standard deviation. 

The variables presented here correspond to the **global mean value** of the signals.

3. "timeBodyAccelerometer.mean.X"                
4. "timeBodyAccelerometer.mean.Y"                
5. "timeBodyAccelerometer.mean.Z"                
6. "timeBodyAccelerometer.std.X"                 
7. "timeBodyAccelerometer.std.Y"                 
8. "timeBodyAccelerometer.std.Z"                 
9. "timeGravityAccelerometer.mean.X"             
10. "timeGravityAccelerometer.mean.Y"             
11. "timeGravityAccelerometer.mean.Z"             
12. "timeGravityAccelerometer.std.X"              
13. "timeGravityAccelerometer.std.Y"              
14. "timeGravityAccelerometer.std.Z"              
15. "timeBodyAccelerometerJerk.mean.X"            
16. "timeBodyAccelerometerJerk.mean.Y"            
17. "timeBodyAccelerometerJerk.mean.Z"            
18. "timeBodyAccelerometerJerk.std.X"             
19. "timeBodyAccelerometerJerk.std.Y"             
20. "timeBodyAccelerometerJerk.std.Z"             
21. "timeBodyGyroscope.mean.X"                    
22. "timeBodyGyroscope.mean.Y"                    
23. "timeBodyGyroscope.mean.Z"                    
24. "timeBodyGyroscope.std.X"                     
25. "timeBodyGyroscope.std.Y"                     
26. "timeBodyGyroscope.std.Z"                     
27. "timeBodyGyroscopeJerk.mean.X"                
28. "timeBodyGyroscopeJerk.mean.Y"                
29. "timeBodyGyroscopeJerk.mean.Z"                
30. "timeBodyGyroscopeJerk.std.X"                 
31. "timeBodyGyroscopeJerk.std.Y"                 
32. "timeBodyGyroscopeJerk.std.Z"                 
33. "timeBodyAccelerometerMagnitude.mean"         
34. "timeBodyAccelerometerMagnitude.std"          
35. "timeGravityAccelerometerMagnitude.mean"      
36. "timeGravityAccelerometerMagnitude.std"       
37. "timeBodyAccelerometerJerkMagnitude.mean"     
38. "timeBodyAccelerometerJerkMagnitude.std"      
39. "timeBodyGyroscopeMagnitude.mean"             
40. "timeBodyGyroscopeMagnitude.std"              
41. "timeBodyGyroscopeJerkMagnitude.mean"         
42. "timeBodyGyroscopeJerkMagnitude.std" 

#### Frequency domain variables
Numeric variables in the frequency domain obtained by applying a Fast Fourier Transform (FFT) to the above mentionned signals.

43. "frequencyBodyAccelerometer.mean.X"           
44. "frequencyBodyAccelerometer.mean.Y"           
45. "frequencyBodyAccelerometer.mean.Z"           
46. "frequencyBodyAccelerometer.std.X"            
47. "frequencyBodyAccelerometer.std.Y"            
48. "frequencyBodyAccelerometer.std.Z"            
49. "frequencyBodyAccelerometerJerk.mean.X"       
50. "frequencyBodyAccelerometerJerk.mean.Y"       
51. "frequencyBodyAccelerometerJerk.mean.Z"       
52. "frequencyBodyAccelerometerJerk.std.X"        
53. "frequencyBodyAccelerometerJerk.std.Y"        
54. "frequencyBodyAccelerometerJerk.std.Z"        
55. "frequencyBodyGyroscope.mean.X"               
56. "frequencyBodyGyroscope.mean.Y"               
57. "frequencyBodyGyroscope.mean.Z"               
58. "frequencyBodyGyroscope.std.X"                
59. "frequencyBodyGyroscope.std.Y"                
60. "frequencyBodyGyroscope.std.Z"                
61. "frequencyBodyAccelerometerMagnitude.mean"    
62. "frequencyBodyAccelerometerMagnitude.std"     
63. "frequencyBodyAccelerometerJerkMagnitude.mean"
64. "frequencyBodyAccelerometerJerkMagnitude.std" 
65. "frequencyBodyGyroscopeMagnitude.mean"        
66. "frequencyBodyGyroscopeMagnitude.std"         
67. "frequencyBodyGyroscopeJerkMagnitude.mean"    
68. "frequencyBodyGyroscopeJerkMagnitude.std"  






## References
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012