def rand_forest(X_train, X_test, Y_train, Y_test):
    # Train model
    from sklearn.ensemble import RandomForestClassifier
    classifier = RandomForestClassifier(n_estimators=100, random_state=0)
    classifier.fit(X_train, Y_train)

    # Predict
    Y_pred = classifier.predict(X_test)


    return Y_pred

