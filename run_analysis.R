trainDat = read.table("dataset/train/X_train.txt")
trainLab = read.table("dataset/train/y_train.txt")

trainSub = read.table("dataset/train/subject_train.txt")
testDat = read.table("dataset/test/X_test.txt")
testLab = read.table("dataset/test/y_test.txt") 

testSub = read.table("dataset/test/subject_test.txt")

joinDat = rbind(trainDat, testDat)
joinLab = rbind(trainLab, testLab)

joinSub = rbind(trainSub, testSub)
#step 1 done

features <- read.table("dataset/features.txt")

mean_std_indices <- grep("mean\\(\\)|std\\(\\)", features[, 2])

joinDat <- joinDat[, mean_Std_indices]

names(joinDat) <- gsub("\\(\\)", "", features[mean_std_indices, 2]) # remove "()"
names(joinDat) <- gsub("mean", "Mean", names(joinDat)) # capitalize M
names(joinDat) <- gsub("std", "Std", names(joinDat)) # capitalize S
names(joinDat) <- gsub("-", "", names(joinDat))
#Step 2 done


activity = read.table("dataset/activity_labels.txt")
activity[, 2] = tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) = toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) = toupper(substr(activity[3, 2], 8, 8))

activityLab = activity[joinLab[, 1], 2]
joinLab[, 1] = activityLab
names(joinLab) = "activity"
names(joinSub) = "subject"
#step 3 and 4 done

cleanedData = cbind(joinSub, joinLab, joinDat)

subLen = length(table(joinSub))
actLen = dim(activity)[1]
colLen = dim(cleanedData)[2]

result = matrix(NA, nrow = subLen * actLen, ncol = colLen) 
result = as.data.frame(result)

colnames(result) = colnames(cleanedData)

row = 1
for(i in 1 : subLen) {
  for(j in 1:actLen) {
    result[row, 1] = sort(unique(joinSub)[, 1])[i]
    result[row, 2] = activity[j, 2]
    bool1 = i == cleanedData$subject
    bool2 = activity[j, 2] == cleanedData$activity
    result[row, 3:colLen] = colMeans(cleanedData[bool1 & bool2, 3:colLen])
    row = row + 1
  }
}
write.table(result, "avg.txt")
#Step 5 done
