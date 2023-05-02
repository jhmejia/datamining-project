random_forest <- function(training_set, test_set, dataset) {

    # Random Forest Regression

    # install.packages('randomForest')

  library(randomForest)
  library(plotly)
  library(caret)
  
  # Function to tune random forest with different values of hyperparameters and calculate R-squared
  tune_random_forest <- function(training_set, test_set, ntree_range, mtry_range, max_depth_range) {
    results <- list()
    for (ntree in ntree_range) {
      for (mtry in mtry_range) {
        for (max_depth in max_depth_range) {
          regressor <- randomForest(formula = victims ~ .,
                                    data = training_set,
                                    ntree = ntree,
                                    mtry = mtry,
                                    max_depth = max_depth)
          y_pred <- predict(regressor, newdata = test_set)
          r_squared <- R2(y_pred, test_set$victims)
          results[[paste0("ntree_", ntree, "_mtry_", mtry, "_max_depth_", max_depth)]] <- r_squared
        }
      }
    }
    return(results)
  }
  
  # Specify ranges of hyperparameters to test
  ntree_range <- seq(50, 300, by = 50)
  mtry_range <- seq(2, ncol(training_set) - 1, by = 2)
  max_depth_range <- seq(2, 10, by = 2)
  
  # Call function to tune random forest and calculate R-squared for each combination of hyperparameters
  results <- tune_random_forest(training_set, test_set, ntree_range, mtry_range, max_depth_range)
  
  # Convert results to data frame for plotting
  result_df <- expand.grid(ntree = ntree_range, mtry = mtry_range, max_depth = max_depth_range)
  result_df$r_squared <- unlist(results)
  
  # Plot R-squared vs hyperparameters using 3D surface plot
  plot_ly(result_df, x = ~mtry, y = ~max_depth, z = ~r_squared, type = "surface",
          colors = c("#d9f0a3", "#addd8e", "#78c679", "#41ab5d", "#238443", "#005a32")) %>%
    layout(scene = list(xaxis = list(title = "mtry"),
                        yaxis = list(title = "max_depth"),
                        zaxis = list(title = "R-squared")))
  
  # Print best hyperparameters and corresponding R-squared value
  best_hyperparameters <- result_df[which.max(result_df$r_squared), ]
  best_ntree <- best_hyperparameters$ntree
  best_mtry <- best_hyperparameters$mtry
  best_max_depth <- best_hyperparameters$max_depth
  best_r_squared <- best_hyperparameters$r_squared
  print(paste0("Best hyperparameters:\nntree = ", best_ntree, "\nmtry = ", best_mtry,
               "\nmax_depth = ", best_max_depth, "\nR-squared = ", best_r_squared))
  
  # Fit final random forest model using best hyperparameters
  regressor <- randomForest(formula = victims ~ .,
                            data = training_set,
                            ntree = best_ntree,
                            mtry = best_mtry,
                            max_depth = best_max_depth)
  y_pred <- predict(regressor, newdata = test_set)
  
  # Print R-squared and mean squared error values for final model
  r_squared <- R2(y_pred, test_set$victims)
  mse <- mean((y_pred - test_set$victims)^2)
  print(paste0("Final model R-squared: ", r_squared))
  print(paste0("Final model mean squared: ", mse))




}