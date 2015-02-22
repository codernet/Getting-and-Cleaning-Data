# Summary

- The code read both train and test data in and then combine them together.
- The feature is filtered by using regular expression and then columns for these features are selected
- Activity IDs are substituted by activity names.
- Feature names are refined
- Combine all datas and then it is transfered to tidy data set

# Variables

- trainDataX, trainDataY, trainDataSubject: train data
- testDataX, testDataY, testDataSubject: test data
- dataX, dataY, dataSubject: merged data
- features: features
- subFeatures: features for mean and stand deviation
- subDataX: merged data containing only mean and stand deviation 
- activityLabel: activity ID
- activityDes: activity ID combined with names 
- data: combined subDataX, dataY, dataSubject
- averageData: tidy data for average