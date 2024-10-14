import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
from sklearn.compose import ColumnTransformer
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout
import joblib

def load_and_preprocess_data(file_path):
    df = pd.read_csv(file_path)
    
    # Separate features and target
    X = df[['AnimalName', 'symptoms1', 'symptoms2', 'symptoms3', 'symptoms4', 'symptoms5']]
    y = df['Dangerous']
    
    # Preprocess categorical variables
    categorical_features = ['AnimalName', 'symptoms1', 'symptoms2', 'symptoms3', 'symptoms4', 'symptoms5']
    preprocessor = ColumnTransformer(
        transformers=[
            ('cat', OneHotEncoder(handle_unknown='ignore', sparse=False), categorical_features)
        ])
    
    X_encoded = preprocessor.fit_transform(X)
    
    # Encode target variable
    label_encoder = LabelEncoder()
    y_encoded = label_encoder.fit_transform(y)
    
    return X_encoded, y_encoded, preprocessor, label_encoder

def create_model(input_dim):
    model = Sequential([
        Dense(64, activation='relu', input_shape=(input_dim,)),
        Dense(32, activation='relu'),
        Dropout(0.3),
        Dense(16, activation='relu'),
        Dense(1, activation='sigmoid')
    ])
    model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])
    return model

def train_and_save_model(file_path):
    # Load and preprocess data
    X_encoded, y_encoded, preprocessor, label_encoder = load_and_preprocess_data(file_path)
    
    # Split data into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(X_encoded, y_encoded, test_size=0.2, random_state=42)
    
    # Create and train the model
    model = create_model(X_train.shape[1])
    model.fit(X_train, y_train, epochs=50, batch_size=32, validation_split=0.2, verbose=1)
    
    # Evaluate the model on test set
    loss, accuracy = model.evaluate(X_test, y_test, verbose=0)
    print(f"Test accuracy: {accuracy:.4f}")
    
    # Save the trained model and preprocessing objects
    model.save('animal_danger_model.h5')
    joblib.dump(preprocessor, 'preprocessor.pkl')
    joblib.dump(label_encoder, 'label_encoder.pkl')
    
    print("Model and preprocessing objects saved successfully.")

if __name__ == '__main__':
    train_and_save_model('./data.csv')