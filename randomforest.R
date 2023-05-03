MSE <- function(y_pred, y_true) {
  mean((y_pred - y_true)^2)
}

R2 <- function(y_pred, y_true) {
  SS_res <- sum((y_true - y_pred)^2)
  SS_tot <- sum((y_true - mean(y_true))^2)
  1 - SS_res/SS_tot
}



random_forest <- function(training_set, test_set, dataset) {

    # Random Forest Regression

    # install.packages('randomForest')

  library(randomForest)
  library(plotly)
  library(caret)
  
   # Do a random forest regression with 500 trees, and 4 variables tried at each split, 
   # and a max depth of 4

  regressor = randomForest(x = training_set[-1], y = training_set$victims, 
  ntree = 500)

  # Predicting the Test set results
  y_pred = predict(regressor, newdata = test_set[-1])

  # Show summary of y pred
  print(summary(y_pred))

  # Show head of y pred
  print(head(y_pred))

  # Show summary of regressor
  print(summary(regressor))


  # Visualising the Random Forest Regression results 
  # (Show distance travelled vs. victims)
  # (Have red points for y_true, and blue line for y_pred)

  # Create a dataframe with the distance travelled and victims
  # for the test set
  test_set_df = test_set$width +  test_set$victims

  # Rename th

  # Show r^2 and MSE
  r2 = R2(y_pred, test_set$victims)
  mse = MSE(y_pred, test_set$victims)

  print(paste("Random Forest Regression R^2: ", r2))
  print(paste("Random Forest Regression MSE: ", mse))

  return (list(r2 = r2, mse = mse, y_pred = y_pred, regressor = regressor))

}


