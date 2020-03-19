#run_analysis.R
#1st task
setwd("C:/Users/hp/desktop/coursera")

features<-read.table("./Newfolder/UCI HAR Dataset/features.txt",
                     col.names = c("n","functions"))
features
activities<-read.table("./Newfolder/UCI HAR Dataset/activity_labels.txt",
col.names = c("code","activity"))
activities
subject_test<-read.table("./Newfolder/UCI HAR Dataset/test/subject_test.txt",
                         col.names = "subject")
subject_test
x_test<-read.table("./Newfolder/UCI HAR Dataset/test/x_test.txt",
                   col.names = features$functions)
x_test
y_test<-read.table("./Newfolder/UCI HAR Dataset/test/y_test.txt",
                   col.names = "code")
y_test
subject_train<-read.table("./Newfolder/UCI HAR Dataset/train/subject_train.txt",
                          col.names = "subject")
subject_train
x_train<-read.table("./Newfolder/UCI HAR Dataset/train/x_train.txt",
                    col.names = features$functions)
x_train
y_train<-read.table("./Newfolder/UCI HAR Dataset/train/y_train.txt",
                    col.names = "code")
y_train

Xmerged<-rbind(x_test,x_train)
Xmerged
Ymerged<-rbind(y_test,y_train)
Ymerged
Subjectmerged<-rbind(subject_test,subject_train)
Subjectmerged
MergedData<-cbind(Xmerged,Ymerged,Subjectmerged)
MergedData
#2nd task Extraction only the measurement containing mean and std

requireddata<-MergedData%>%
              select(subject,code,contains("mean"),contains("std"))
requireddata
#3rd task
requireddata$code<-activities[requireddata$code,2 ]
requireddata$code
#4rth task
names(requireddata)[2]
names(requireddata)[2] = "activity"
names_1<-gsub("Acc", "Accelerometer", names(requireddata))
names_1

names_2<-gsub("Gyro", "Gyroscope", names(requireddata))
names_2
names_3<-gsub("BodyBody", "Body", names(requireddata))
names_3
names_4<-gsub("Mag", "Magnitude", names(requireddata))
names_4
names_5<-gsub("^t", "Time", names(requireddata))
names_5
names_6<-gsub("^f", "Frequency", names(requireddata))
names_6
names_7<-gsub("tBody", "TimeBody", names(requireddata))
names_7
names_8<-gsub("-mean()", "Mean", names(requireddata), ignore.case = TRUE)
names_8
names_9<-gsub("-std()", "STD", names(requireddata), ignore.case = TRUE)
names_9
names_10<-gsub("-freq()", "Frequency", names(requireddata), ignore.case = TRUE)
names_10
names_11<-gsub("angle", "Angle", names(requireddata))
names_11
names_12<-gsub("gravity", "Gravity", names(requireddata))
names_12
#5th task
finaltidydata<- requireddata %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(finaltidydata, "finaltidydata.txt", row.name=FALSE)
finaltidydata
str(finaltidydata)

