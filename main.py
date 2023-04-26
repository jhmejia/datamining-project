# Import libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Import functions from other files
from preprocessing import preprocess
from random_forest import rand_forest
# from linear_regression import lin_reg
from svr import svr

file_path = 'us_tornado_dataset_1950_2021.csv'

# Preprocess data
X_train, X_test, Y_train, Y_test = preprocess(file_path)


print("X_train: ", X_train)


# Linear Regression model (includes polynomial features,
# regularization, backward elimination, and feature scaling)



# Support Vector Regression model ()
print("Calling SVR... (Will take foreva) ")

Y_pred = svr(X_train, X_test, Y_train, Y_test)



# Plot it 

# X is wid, Y is vic
# We use RED DOTS to show predicted victims and BLUE dots for ACTUAL victims. 

# Identify the column index of the width column
width_col = X_train.get_loc('wid')

plt.scatter(X_test[:, 0], Y_test, color='blue')
plt.scatter(X_test[:, 0], Y_pred, color='red')
plt.title('Victims vs. Tornado Width (SVR)')
plt.xlabel('Tornado Width')
plt.ylabel('Victims')
plt.show()


# Random Forest Regression model
Y_pred = rand_forest(X_train, X_test, Y_train, Y_test)

# Evaluate performance of regression model by r^2 score
from sklearn.metrics import r2_score
print("R^2 score: ", r2_score(Y_test, Y_pred))

# Evaluate performance of regression model by mean squared error
from sklearn.metrics import mean_squared_error
print("Mean squared error: ", mean_squared_error(Y_test, Y_pred))

# Visualizing the Random Forest Regression results like the midterm

