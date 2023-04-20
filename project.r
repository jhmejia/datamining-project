# read the data

dataset <- read.csv("us_tornado_dataset_1950_2021.csv")

# Encode the 'st' column as a factor

dataset$st <- factor(dataset$st, levels = unique(dataset$st))

# Drop the 'date' column since we already have the 'year' column

# Locate the column index of 'date' and drop it

dataset <- dataset[, -which(names(dataset) == "date")]

print(colnames(dataset))

# Split the data into training and testing sets

# What we will be predicting is the 'wid' column ('width' of the tornado')

library(caTools)
set.seed(123)
split = sample.split(dataset$wid, SplitRatio = 0.75)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)