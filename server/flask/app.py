import os
os.environ['TF_ENABLE_ONEDNN_OPTS'] = '0'  # Disable oneDNN custom operations

from flask import Flask, request, jsonify, render_template
from tensorflow.keras.models import load_model
import numpy as np
import pandas as pd
import joblib
from reportanalysis.report_analyzer import analyze_reports
import io
from petfoodrecipe.pet_food_model import PetFoodModel

app = Flask(__name__)

# Global variables to store models and preprocessors
animal_model = None
pet_food_model = None
preprocessor = None
label_encoder = None
models_loaded = False

def load_models():
    global animal_model, pet_food_model, preprocessor, label_encoder, models_loaded
    
    if not models_loaded:
        print("Loading models...")
        # Load models and preprocessors for animal condition prediction
        animal_model = load_model('animalcondition/animal_danger_model.h5')
        preprocessor = joblib.load('animalcondition/preprocessor.pkl')
        label_encoder = joblib.load('animalcondition/label_encoder.pkl')

        # Load the pet food prediction model
        pet_food_model = PetFoodModel.load_model('./petfoodrecipe/pet_food_model.joblib')

        models_loaded = True
        print("Models loaded successfully.")

@app.before_request
def before_request():
    load_models()

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

@app.route('/analyze_medical_reports', methods=['POST'])
def analyze_medical_reports():
    if 'files' not in request.files:
        return jsonify({'error': 'No files part in the request'}), 400
    
    files = request.files.getlist('files')
    
    if not files or files[0].filename == '':
        return jsonify({'error': 'No files selected for uploading'}), 400
    
    try:
        file_objects = []
        for file in files:
            file_object = io.BytesIO(file.read())
            file_object.name = file.filename
            file_objects.append(file_object)
        
        results = analyze_reports(file_objects)
        
        return jsonify({'analysis': results})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/predict_pet_food', methods=['POST'])
def predict_pet_food():
    data = request.json
    breed = data.get('breed')
    ingredients = data.get('ingredients')

    if not breed or not ingredients:
        return jsonify({'error': 'Missing breed or ingredients'}), 400

    try:
        recipe, cooking_method = pet_food_model.predict(breed, ingredients)
        return jsonify({
            'recipe_name': recipe,
            'cooking_method': cooking_method,
            'note': 'This prediction is based on the closest match in our database.'
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=False, port=8000, host='0.0.0.0')