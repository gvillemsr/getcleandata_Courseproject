test<-read.table("UCI HAR Dataset/test/X_test.txt", sep="",header=FALSE)
train<-read.table("UCI HAR Dataset/train/X_train.txt", sep="",header=FALSE)
extcols<-c(1:6,41:46,81:86,121:126,161:166,201:202,214,215,227,228,240,241,253,254)
extcols2<-c(266:271,345:350,424:429,503,504,516,517,529,530,542,543)
extract<-c(extcols,extcols2)
testsampsubs<-subset(test,select=extract)
trainsampsubs<-subset(train,select=extract)
datasub<-rbind(testsampsubs,trainsampsubs)
testsubj<-read.table("UCI HAR Dataset/test/subject_test.txt", sep="",header=FALSE)
trainsubj<-read.table("UCI HAR Dataset/train/subject_train.txt", sep="",header=FALSE)
subjects<-rbind(testsubj,trainsubj)
colnames(subjects)<-c("subject")
testactiv<-read.table("UCI HAR Dataset/test/y_test.txt", sep="",header=FALSE)
trainactiv<-read.table("UCI HAR Dataset/train/y_train.txt", sep="",header=FALSE)
activity<-rbind(testactiv,trainactiv)
colnames(activity)<-c("Activity")
dataset<-cbind(subjects,activity,datasub)
names<-read.table("UCI HAR Dataset/features.txt", sep="",header=FALSE)
names<-subset(names,select=c(2))
names<-t(names)
namessub<-subset(names,select=extract)
colnames(dataset)<-cbind(colnames(subjects),colnames(activity),namessub)
dataset$Activity<-as.numeric(dataset$Activity)
dataset$Activity<-factor(dataset$Activity)
levels(dataset$Activity)[1]<-"Walking"
levels(dataset$Activity)[2]<-"Walking_upstairs"
levels(dataset$Activity)[3]<-"Walking_downstairs"
levels(dataset$Activity)[4]<-"Sitting"
levels(dataset$Activity)[5]<-"Standing"
levels(dataset$Activity)[6]<-"Laying"
bysubj<-dataset$subject
byactivity<-dataset$Activity
tidydata<-aggregate(dataset[,3:68], by=list(bysubj,byactivity),FUN="mean")
colnames(tidydata)[1]<-"Subject"
colnames(tidydata)[2]<-"Activity"
write.table(tidydata, "tidydata.txt", sep=" ",col.names=F, row.names=F)
cnames<-colnames(tidydata)
write.table(cnames, "column_names.txt", sep=" ",col.names=F, quote=F)
