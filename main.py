# Import libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Import functions from other files
from preprocessing import preprocess
from random_forest import rand_forest
from svr import svr

file_path = 'us_tornado_dataset_1950_2021.csv'

# Preprocess data
X_train, X_test, Y_train, Y_test = preprocess(file_path)

# Random Forest Regression model
Y_pred_rfr = rand_forest(X_train, X_test, Y_train, Y_test)

# SVR model
y_pred_svr = svr(X_trainm X_test, Y_train, Y_test)

# Evaluate performance of model 1
from sklearn.metrics import confusion_matrix, accuracy_score
cm = confusion_matrix(Y_test, Y_pred_rfr)
print(cm)
accuracy_score(Y_test, Y_pred_rfr)