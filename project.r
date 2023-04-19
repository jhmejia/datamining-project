# read the data

data <- read.csv("us_tornado_dataset_1950_2021.csv")

# Encode the 'st' column as a factor

data$st <- as.factor(data$st)

# Drop the 'date' column since we already have the 'year' column

# Locate the column index of 'date' and drop it

data <- data[, -which(names(data) == "date")]

print(colnames(data))

# Split the data into training and testing sets

set.seed(123)


