
# Function to pre process the tornado dataset file given the filepath. 
def preprocess(file_path):
    # Get libraries
    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt

    # Import data
    df = pd.read_csv(file_path)

    # Data preprocessing

    # one hot encode 'st' 
    df_one_hot = pd.get_dummies(df, columns=['st'])
    df = pd.concat([df, df_one_hot], axis=1)

    # drop 'st' column (already one hot encoded)
    df = df.drop('st', axis=1)

    # Drop date column since we have year and month
    df = df.drop(['date'], axis=1)

    # Remove 'mag' column
    df = df.drop(['mag'], axis=1)

    X = df.iloc[:, :-1].to_numpy()
    Y = df.iloc[:, -1].to_numpy()

    # Split data into train and test
    from sklearn.model_selection import train_test_split
    X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.2, random_state=0)



    # Scale data
    from sklearn.preprocessing import StandardScaler
    sc = StandardScaler()
    X_train = sc.fit_transform(X_train)
    X_test = sc.transform(X_test)

    return X_train, X_test, Y_train, Y_test
