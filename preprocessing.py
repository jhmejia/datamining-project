
# Function to pre process the tornado dataset file given the filepath. 
def preprocess(file_path):
    # Get libraries
    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt

    # Import data
    df = pd.read_csv(file_path)

    # Data preprocessing

    # Remove 'st' column

    df = df.drop(['st'], axis=1)

    # Drop date column since we have year and month
    df = df.drop(['date'], axis=1)

    # Drop 'year' and 'day' columns
    df = df.drop(['yr', 'dy'], axis=1)

    # Encode 'mo' into 4 seasons 
    # Winter: 12, 1, 2
    # Spring: 3, 4, 5
    # Summer: 6, 7, 8
    # Fall: 9, 10, 11
    df['mo'] = df['mo'].replace([12, 1, 2], 0)
    df['mo'] = df['mo'].replace([3, 4, 5], 1)
    df['mo'] = df['mo'].replace([6, 7, 8], 2)
    df['mo'] = df['mo'].replace([9, 10, 11], 3)

    # Rename 'mo' to 'season'

    df = df.rename(columns={'mo': 'season'})

    # One hot encode season column
    df = pd.get_dummies(df, columns=['season'])
    

    # Combine fatalities and injuries into one column
    df['vic'] = df['fat'] + df['inj'] # vic = victims

    # Drop fatalities and injuries columns
    df = df.drop(['fat'], axis=1)
    df = df.drop(['inj'], axis=1)



    # If ending elat is 0, replace with slat. (unknown ending lat)

    # Same with elon


    # Replace values in 'elat' column that are equal to 0 with values from 'slat' column
    df['elat'] = df['elat'].mask(df['elat'] == 0, df['slat'])

    # Replace values in 'elon' column that are equal to 0 with values from 'slon' column
    df['elon'] = df['elon'].mask(df['elon'] == 0, df['slon'])




    # If magnitude is -9, replace with the average magnitude of the ones that are not -9

    # get all rows where mag is not -9
    mag_known = df[df['mag'] != -9]

    # get average of mag
    mag_avg = mag_known['mag'].mean()

    # replace -9 with mag_avg
    df['mag'] = df['mag'].replace(-9, mag_avg)


    print(df.head())

    # Split data into X and Y
    X = df.iloc[:, :-1].values
    Y = df.iloc[:, -1].values

    # Split data into train and test
    from sklearn.model_selection import train_test_split
    X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.2, random_state=0)



    # Scale data
    # Moved to model classes to grant access to scaler
    '''
    from sklearn.preprocessing import StandardScaler
    sc = StandardScaler()
    X_train = sc.fit_transform(X_train)
    X_test = sc.transform(X_test)
    '''

    return X_train, X_test, Y_train, Y_test

 
    

if __name__ == '__main__':
    preprocess('us_tornado_dataset_1950_2021.csv')