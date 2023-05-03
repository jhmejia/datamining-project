###########################
# Data Mining Group Project
# John Henry, Bao Nguyen, Mason O connor
#############################


# Data PreProcessing

#Load the Data

dataset <- read.csv("us_tornado_dataset_1950_2021.csv")


# Drop the 'st' column (lat long cover it) (the 3rd column)
dataset = subset(dataset, select = -c(st))


# Drop the 'year', 'date', 'day' columns (date is covered, year day irrelevant)

dataset = subset(dataset, select = -c(date, yr, dy))


# Encode month into seasons

# Spring = 0, Summer = 1, Fall = 2, Winter = 3
# Spring months: 3, 4, 5
# Summer months: 6, 7, 8
# Fall months: 9, 10, 11
# Winter months: 12, 1, 2

# Create a new column called 'season' and set it to 0

dataset$season = 0

# Replace values in 'season' column that are equal to 0 with values from 'mo' column

dataset$season[dataset$mo == 3] = 0
dataset$season[dataset$mo == 4] = 0
dataset$season[dataset$mo == 5] = 0
dataset$season[dataset$mo == 6] = 1
dataset$season[dataset$mo == 7] = 1
dataset$season[dataset$mo == 8] = 1
dataset$season[dataset$mo == 9] = 2
dataset$season[dataset$mo == 10] = 2
dataset$season[dataset$mo == 11] = 2
dataset$season[dataset$mo == 12] = 3
dataset$season[dataset$mo == 1] = 3
dataset$season[dataset$mo == 2] = 3

# Drop the 'mo' column
dataset = subset(dataset, select = -c(mo))


# If ending elat is 0, replace with slat. (unknown ending lat)
# Same with elon


dataset$elat = ifelse(dataset$elat == 0, dataset$slat, dataset$elat)

dataset$elon = ifelse(dataset$elon == 0, dataset$slon, dataset$elon)




# If magnitude is -9, replace with the average magnitude of the ones that are not -9

# get all rows where mag is not -9

dataset$mag[dataset$mag == -9] = NA

# get average of mag

mag_avg = mean(dataset$mag, na.rm = TRUE)

# replace -9 with mag_avg

dataset$mag[is.na(dataset$mag)] = mag_avg

# Add "distance covered" column
# =acos(sin(lat1)*sin(lat2)+cos(lat1)*cos(lat2)*cos(lon2-lon1))*6371

# Add "distance covered" column

# dataset$distance = acos(sin(dataset$slat)*sin(dataset$elat)+cos(dataset$slat)*cos(dataset$elat)*cos(dataset$elon-dataset$slon))*6371
# 
# dataset$distance[dataset$distance == -0] = NA
# 
# dist_avg = mean(dataset$distance, na.rm = TRUE)
# 
# dataset$distance[is.na(dataset$distance)] = dist_avg



# Get victims (fatalities + injuries)

dataset$victims = dataset$inj + dataset$fat

# Drop the 'inj' and 'fat' columns

dataset = subset(dataset, select = -c(inj, fat))


# Splitting the dataset into the Training set and Test set


library(caTools)

source("randomforest.R")



for (i in 1:5) {
  # Do not set seed for splitting. 
  split = sample.split(dataset$wid, SplitRatio = 0.80)
  training_set = subset(dataset, split == TRUE)
  test_set = subset(dataset, split == FALSE)
  random_forest(training_set, test_set, dataset)
}

