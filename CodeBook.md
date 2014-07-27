trainDat - contains data read from Xtrain.txt
trainLab - contains data read from Ytrain.txt
trainSub - test data read from subject_train.txt
testDat - test data read from x_test.txt
testLab - test data read from y_test.txt 
testSub - test data read from subject_test.txt
joinDat - combines trainDat and testDat
joinLab - combines trainLab and testLab
joinSub - combines trainSub and testSub
features - contains data read from features.txt
mean_std_indices - initially used to store the cleaned column names (remove '()' and '-'.. make them Camelcase)
activity - activity labels
cleanedData - cleaned merged data
result - second independent tidy dataset with the average of each measurement for each activity and each subject
