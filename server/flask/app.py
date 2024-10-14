from flask import Flask, request, jsonify, render_template
from tensorflow.keras.models import load_model
from tensorflow.keras.layers import TextVectorization
import numpy as np
import pandas as pd
import joblib

app = Flask(__name__)

# Load models and preprocessors for animal condition prediction
animal_model = load_model('animalcondition/animal_danger_model.h5')
preprocessor = joblib.load('animalcondition/preprocessor.pkl')
label_encoder = joblib.load('animalcondition/label_encoder.pkl')

# Load model and prepare vectorizer for comment toxicity prediction
toxicity_model = load_model('checkcommenttoxicity/toxicity.h5')

# Load dataset to adapt the TextVectorizer
df = pd.read_csv('checkcommenttoxicity/train.csv')
MAX_FEATURES = 200000

vectorizer = TextVectorization(max_tokens=MAX_FEATURES,
                               output_sequence_length=2000,
                               output_mode='int')
vectorizer.adapt(df['comment_text'].values)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/check_animal_condition', methods=['POST'])
def predict_animal():
    data = request.json
    
    required_fields = ['AnimalName', 'symptoms1', 'symptoms2', 'symptoms3', 'symptoms4', 'symptoms5']
    if not all(field in data for field in required_fields):
        return jsonify({'error': 'Missing required fields'}), 400
    
    input_df = pd.DataFrame([data])
    
    input_df = input_df[required_fields]
    
    input_encoded = preprocessor.transform(input_df).toarray()
    
    # Make prediction
    prediction = animal_model.predict(input_encoded)
    
    # Convert prediction to label
    predicted_label = label_encoder.inverse_transform([round(prediction[0][0])])[0]
    
    return jsonify({
        'prediction': str(predicted_label),
        'probability': float(prediction[0][0])
    })

@app.route('/check_comment_toxicity', methods=['POST'])
def predict_toxicity():
  
    data = request.json
    comment_text = data['text']
    
    vectorized_text = vectorizer([comment_text])
    
    prediction = (toxicity_model.predict(vectorized_text) > 0.5).astype(int).tolist()
    

    return jsonify({'prediction': prediction})

if __name__ == '__main__':
    app.run(debug=True, port=8000)