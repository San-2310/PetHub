import os
import pandas as pd
import tensorflow as tf
import numpy as np
from tensorflow.keras.layers import TextVectorization
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM, Dropout, Bidirectional, Dense, Embedding
from tensorflow.keras.metrics import Precision, Recall, CategoricalAccuracy
from matplotlib import pyplot as plt

# Check current working directory
print(os.getcwd()) 

# Load dataset (ensure 'train.csv' is in the correct directory)
df = pd.read_csv(os.path.join('train.csv'))

# Inspect dataset
print(df.head())
print(df.tail())
print(df.iloc[3]['comment_text'])
print(df[df.columns[2:]].iloc[3])

# Preprocess Data
X = df['comment_text']
y = df[df.columns[2:]].values  # Converts data to array using .values

# Set maximum features (vocabulary size)
MAX_FEATURES = 200000

# Create a TextVectorization layer
vectorizer = TextVectorization(max_tokens=MAX_FEATURES,
                               output_sequence_length=2000,  # Comment max length
                               output_mode='int')

# Adapt the vectorizer to the text data
vectorizer.adapt(X.values)  # .values converts pd series to numpy array & .adapt learns the vocabulary

# Example transformation
print(vectorizer('Hello world'))

# Vectorize the text data
vectorized_text = vectorizer(X.values)

# Create TensorFlow dataset for pipelining
dataset = tf.data.Dataset.from_tensor_slices((vectorized_text, y))
dataset = dataset.cache()
dataset = dataset.shuffle(160000)
dataset = dataset.batch(16)
dataset = dataset.prefetch(8)  # Helps prevent bottlenecks

# Split the dataset into train, validation, and test sets
train = dataset.take(int(len(dataset) * 0.7))
val = dataset.skip(int(len(dataset) * 0.7)).take(int(len(dataset) * 0.2))
test = dataset.skip(int(len(dataset) * 0.9)).take(int(len(dataset) * 0.1))

# Create a Sequential model
model = Sequential()

# Add an Embedding layer
model.add(Embedding(MAX_FEATURES + 1, 32))

# Add a Bidirectional LSTM layer
model.add(Bidirectional(LSTM(32, activation='tanh')))

# Add Dense layers
model.add(Dense(128, activation='relu'))
model.add(Dense(256, activation='relu'))
model.add(Dense(128, activation='relu'))

# Final output layer with sigmoid activation for multi-label classification
model.add(Dense(6, activation='sigmoid'))

# Compile the model
model.compile(loss='BinaryCrossentropy', optimizer='Adam')

# Print model summary
model.summary()

# Train the model
history = model.fit(train, epochs=3, validation_data=val)

# Plot training history
plt.plot(history.history['loss'], label='train_loss')
plt.plot(history.history['val_loss'], label='val_loss')
plt.legend()
plt.show()

# Make Predictions
input_text = vectorizer("You freaking suck!")
batch = test.as_numpy_iterator().next()
batch_X, batch_y = test.as_numpy_iterator().next()

# Predict the classes for the test batch
print((model.predict(batch_X) > 0.5).astype(int))

# Model evaluation on test set
res = model.predict(batch)

# Initialize evaluation metrics
pre = Precision()
re = Recall()
acc = CategoricalAccuracy()

# Evaluate model on test set
for batch_X, batch_y in test.as_numpy_iterator():
    y_pred = model.predict(batch_X)
    y_pred = (y_pred > 0.5).astype(int)  # Convert probabilities to binary predictions

    # Update the metrics
    pre.update_state(batch_y, y_pred)
    re.update_state(batch_y, y_pred)
    acc.update_state(batch_y, y_pred)

# Print evaluation metrics
print(f"Precision: {pre.result().numpy()}")
print(f"Recall: {re.result().numpy()}")
print(f"Categorical Accuracy: {acc.result().numpy()}")
