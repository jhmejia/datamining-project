def svr(X_train, X_test, Y_train, Y_test):

    # Try RBF kernel
    from sklearn.svm import SVR
    regressor = SVR(kernel='rbf')
    regressor.fit(X_train, Y_train)

    # Predict
    Y_pred = regressor.predict(X_test)

    # Evaluate performance of regression model by r^2 score
    from sklearn.metrics import r2_score
    print("R^2 score: ", r2_score(Y_test, Y_pred))

    return Y_pred


        


if __name__ == "__main__":
    # Import libraries
    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt

    # Import functions from other files
    from preprocessing import preprocess
    from random_forest import rand_forest
    #from linear_regression import lin_reg
    from svr import svr

    file_path = 'us_tornado_dataset_1950_2021.csv'

    # Preprocess data
    X_train, X_test, Y_train, Y_test = preprocess(file_path)

    # Linear Regression model (includes polynomial features,
    # regularization, backward elimination, and feature scaling)
    svr(X_train, X_test, Y_train, Y_test)
