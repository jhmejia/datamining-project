# Import libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Import functions from other files
from preprocessing import preprocess
from random_forest import rand_forest

file_path = 'us_tornado_dataset_1950_2021.csv'

# Preprocess data
X_train, X_test, Y_train, Y_test = preprocess(file_path)

# Random Forest Regression model
Y_pred = rand_forest(X_train, X_test, Y_train, Y_test)

# Evaluate performance of regression model by r^2 score
from sklearn.metrics import r2_score
print(r2_score(Y_test, Y_pred))

# Evaluate performance of regression model by mean squared error
from sklearn.metrics import mean_squared_error
print(mean_squared_error(Y_test, Y_pred))

# Visualize results
plt.scatter(Y_test, Y_pred, color='blue')
plt.title('Random Forest Regression')
plt.xlabel('Actual')
plt.ylabel('Predicted')
plt.show()

