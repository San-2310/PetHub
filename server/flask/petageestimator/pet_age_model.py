import os
import pandas as pd
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Conv2D, MaxPooling2D, Flatten, Dense, Dropout
from tensorflow.keras.preprocessing.image import ImageDataGenerator
import joblib

# Load updated train and validation data
def load_data(train_file, val_file):
    train_data = pd.read_csv(train_file, sep="\t", header=None, names=['image_name', 'age_month'])
    val_data = pd.read_csv(val_file, sep="\t", header=None, names=['image_name', 'age_month'])
    
    return train_data, val_data

# Define the CNN model
def create_model():
    model = Sequential([
        Conv2D(32, (3, 3), activation='relu', input_shape=(64, 64, 3)),
        MaxPooling2D(pool_size=(2, 2)),
        Conv2D(64, (3, 3), activation='relu'),
        MaxPooling2D(pool_size=(2, 2)),
        Flatten(),
        Dense(128, activation='relu'),
        Dropout(0.5),
        Dense(1, activation='linear')  # Regression output for predicting age in months
    ])
    
    # Compile the model
    model.compile(optimizer='adam', loss='mean_squared_error', metrics=['mae'])
    return model

# Function to train the model
def train_model(model, train_data, val_data, epochs=20, batch_size=32):
    # Image augmentation and data generation
    train_datagen = ImageDataGenerator(rescale=1./255, horizontal_flip=True)
    val_datagen = ImageDataGenerator(rescale=1./255)
    
    # Ensure the directory and file paths are correct
    train_generator = train_datagen.flow_from_dataframe(
        dataframe=train_data,
        directory='testset',  # Directory containing your images
        x_col='image_name',
        y_col='age_month',
        target_size=(64, 64),
        batch_size=batch_size,
        class_mode='raw',  # 'raw' for regression tasks
        shuffle=True
    )
    
    val_generator = val_datagen.flow_from_dataframe(
        dataframe=val_data,
        directory='testset',  # Use the same directory for validation images
        x_col='image_name',
        y_col='age_month',
        target_size=(64, 64),
        batch_size=batch_size,
        class_mode='raw',  # 'raw' for regression tasks
        shuffle=False
    )
    
    # Train the model
    history = model.fit(
        train_generator,
        steps_per_epoch=len(train_data) // batch_size,
        epochs=epochs,
        validation_data=val_generator,
        validation_steps=len(val_data) // batch_size
    )
    
    return history

# Main script execution
if __name__ == "__main__":
    # Load the data
    train_df, val_df = load_data('train_updated.txt', 'val_updated.txt')
    
    # Create the model
    model = create_model()
    
    # Train the model
    history = train_model(model, train_df, val_df)
    
    # Save the model using joblib
    joblib.dump(model, 'pet_age_model.joblib')
    
    print("Model training completed and saved using joblib.")