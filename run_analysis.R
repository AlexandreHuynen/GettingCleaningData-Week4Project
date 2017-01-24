library(data.table)
library(plyr)

# We start this script by checking if the folder 'UCI HAR Dataset' is in the 
# current directory or in a subdirectory. If not, it is downloaded.
foldername <- "UCI HAR Dataset"
listdirs <- list.dirs()

if(!any(grepl(pattern = foldername, listdirs))){
        # The folder is not in the directory or a subdirectory
        # It is thus downloaded and unzipped
        temp <- tempfile()
        fileUrl <- paste("https://d396qusza40orc.cloudfront.net/",
                         "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                         sep = "")
        download.file(fileUrl, temp, method = "curl")
        if (!file.exists("data")){ dir.create("data") }
        unzip(temp, exdir = "./data")
        unlink(temp)
        # The path to the folder is stored in the variable 'datapath'
        datapath <- file.path("./data", foldername)
} else {
        # The folder already exist, we extract its path and store it in the 
        # variable 'datapath'
        datapath <- grep(pattern = foldername, listdirs, value = TRUE)[1]
}

# Reading the data
acti <- read.table(file.path(datapath, "activity_labels.txt"))
feat <- read.table(file.path(datapath, "features.txt"))

# Train data
xtrain <- read.table(file.path(datapath, "train/X_train.txt"))
ytrain <- read.table(file.path(datapath, "train/Y_train.txt"))
subtrain <- read.table(file.path(datapath, "train/subject_train.txt"))

# Test data
xtest <- read.table(file.path(datapath, "test/X_test.txt"))
ytest <- read.table(file.path(datapath, "test/Y_test.txt"))
subtest <- read.table(file.path(datapath, "test/subject_test.txt"))

# 1. Merges the training and the test sets to create one data set
xtot <- rbind(xtrain, xtest)
names(xtot) <- feat[,2]

ytot <- rbind(ytrain, ytest)
names(ytot) <- "activity"

subtot <- rbind(subtrain, subtest)
names(subtot) <- "subject"

data <- cbind(subtot, ytot, xtot)

# 2. Extracts only the measurements on the mean and standard deviation for each
#    measurement
subdata <- data[, grepl("mean\\(\\)|std\\(\\)|subject|activity", names(data))]

# 3. Uses descriptive activity names to name the activities in the data set
subdata$activity <- factor(x = subdata$activity, labels = acti$V2)

# 4. Appropriately labels the data set with descriptive variable names
names(subdata) <- gsub("\\(\\)", "", names(subdata))
names(subdata) <- gsub("^t", "time", names(subdata))
names(subdata) <- gsub("^f", "frequency", names(subdata))
names(subdata) <- gsub("Acc", "Accelerometer", names(subdata))
names(subdata) <- gsub("Gyro", "Gyroscope", names(subdata))
names(subdata) <- gsub("Mag", "Magnitude", names(subdata))
names(subdata) <- gsub("BodyBody", "Body", names(subdata))

names(subdata) <- make.names(names(subdata))

# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
subdata$subject <- as.factor(subdata$subject)
tidydata <- ddply(subdata, c("subject","activity"), numcolwise(mean))

write.table(tidydata, file = "tidydata.txt", row.name = FALSE)
