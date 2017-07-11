# This R script reads Mean and Standard Deviation columns from two data files: X_train.txt and X_test.txt
# and loads them into separate data frames ('train' and 'test'), then combines them into one data frame ('both'),
# along with a Subject column to designate one of the 30 subjects for each sample observation (row)
# It then summarizes each variable, taking the mean by Subject number in data frame ('both_means')

# Use 'cols' to select the column numbers which are Mean and SD columns

cols <- c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,253,254,
          266:271,345:350,424:429,503,504,516,517,529,530,542,543)

train <- read.table("X_train.txt")      #Read training data
train <- train[,cols]                   #Only selected columns
trainAct <- read.table("y_train.txt")          #Read Activity number
trainSubj <- read.table("subject_train.txt")   #Read Subject number
train <- cbind(trainSubj,trainAct,train)         #Add subject column

test <- read.table("X_test.txt")        #Read test data
test <- test[,cols]                     #Only selected columns
testAct <- read.table("y_test.txt")          #Read Activity number
testSubj <- read.table("subject_test.txt")     #Read subject number
test <- cbind(testSubj,testAct,test)            #Add subject column

both <- rbind(train,test)               #combine Train and Test data into data frame 'both'

# Vector of variable names

colNames <- c("Subject","Activity","tBA_Xmean","tBA_Ymean","tBA_Zmean","tBA_Xstd","tBA_Ystd","tBA_Zstd",
              "tGA_Xmean","tGA_Ymean","tGA_Zmean","tGA_Xstd","tGA_Ystd","tGA_Zstd",
              "tBAJ_Xmean","tBAJ_Ymean","tBAJ_Zmean","tBAJ_Xstd","tBAJ_Ystd","tBAJ_Zstd",
              "tBG_Xmean","tBG_Ymean","tBG_Zmean","tBG_Xstd","tBG_Ystd","tBG_Zstd",
              "tBGJ_Xmean","tBGJ_Ymean","tBGJ_Zmean","tBGJ_Xstd","tBGJ_Ystd","tBGJ_Zstd",
              "tBAM_mean","tBAM_std","tGAM_mean","tGAM_std","tBAJM_mean","tBAJM_std",
              "tBGM_mean","tBGM_std","tBGJM_mean","tBGJM_std",
              "fBA_Xmean","fBA_Ymean","fBA_Zmean","fBA_Xstd","fBA_Ystd","fBA_Zstd",
              "fBAJ_Xmean","fBAJ_Ymean","fBAJ_Zmean","fBAJ_Xstd","fBAJ_Ystd","fBAJ_Zstd",
              "fBG_Xmean","fBG_Ymean","fBG_Zmean","fBG_Xstd","fBG_Ystd","fBG_Zstd",
              "fBAM_mean","fBAM_std","fBBAJM_mean","fBBAJM_std",
              "fBBGM_mean","fBBGM_std","fBBGJM_mean","fBBGJM_std")

colnames(both) <- colNames     #Apply vector to column names
both$Activity <- as.factor(both$Activity)

levels(both$Activity)[levels(both$Activity)=="1"] <- "WALKING"
levels(both$Activity)[levels(both$Activity)=="2"] <- "WALKING_UPSTAIRS"
levels(both$Activity)[levels(both$Activity)=="3"] <- "WALKING_DOWNSTAIRS"
levels(both$Activity)[levels(both$Activity)=="4"] <- "SITTING"
levels(both$Activity)[levels(both$Activity)=="5"] <- "STANDING"
levels(both$Activity)[levels(both$Activity)=="6"] <- "LAYING"

write.table(both, "./both.txt", sep=" ",row.name=FALSE)

#install.packages("dplyr")
#library(dplyr)

# group 'both' by subject
both2 <- group_by(both,Subject,Activity)
  
# 'both_means' uses summarize_all to calculate mean of each variable by Subject number using 'dplyr' package
both_means <- summarize_all(both2,mean)
write.table(both_means, "./both_means.txt", sep=" ",row.name=FALSE)
                  
                   
