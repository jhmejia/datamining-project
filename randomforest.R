random_forest <- function(training_set, test_set, dataset) {

    # Random Forest Regression

    # install.packages('randomForest')

  library(randomForest)
  library(ggplot2)
  
  regressor <- randomForest(formula = victims ~ .,
                            data = training_set,
                            ntree = 100)
  
  # Create a grid of values for the length of the track
  x_grid <- seq(min(training_set$len), max(training_set$len), 0.1)
  
  # Plot the training data points and the predicted values from the random forest model
  ggplot() +
    geom_point(aes(x = training_set$len, y = training_set$victims),
               colour = 'red') +
    geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(len = x_grid))),
              colour = 'blue') +
    ggtitle('Random Forest Regression') +
    xlab('Length of track') +
    ylab('Number of victims')
  

    # Finding mean absolute error

    y_pred = predict(regressor, newdata = test_set)

    mean_absolute_error = mean(abs(y_pred - test_set$victims))

    print(mean_absolute_error)
    

}