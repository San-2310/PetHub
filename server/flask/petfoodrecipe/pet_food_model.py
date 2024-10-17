import pandas as pd
import numpy as np
from sklearn.neighbors import KNeighborsClassifier
from sklearn.preprocessing import LabelEncoder, StandardScaler
from sklearn.feature_extraction.text import CountVectorizer
import joblib

class PetFoodModel:
    def __init__(self):
        self.label_encoder_breed = LabelEncoder()
        self.label_encoder_recipe = LabelEncoder()
        self.label_encoder_cooking = LabelEncoder()
        self.ingredient_vectorizer = CountVectorizer()
        self.scaler = StandardScaler()
        self.knn_recipe = KNeighborsClassifier(n_neighbors=5)
        self.knn_cooking = KNeighborsClassifier(n_neighbors=5)
    
    def preprocess_data(self, df):
        df_copy = df.copy()
        
        # Combine ingredients into a single column
        ingredient_columns = [f'ingredients[{i}].name' for i in range(6)]
        df_copy['ingredients_combined'] = df_copy[ingredient_columns].fillna('').agg(' '.join, axis=1)
        
        X = pd.DataFrame()
        X['breed_encoded'] = self.label_encoder_breed.fit_transform(df_copy['breed'])
        
        # Use CountVectorizer for ingredients
        ingredients_vectorized = self.ingredient_vectorizer.fit_transform(df_copy['ingredients_combined'])
        ingredients_df = pd.DataFrame(ingredients_vectorized.toarray(), 
                                      columns=self.ingredient_vectorizer.get_feature_names_out())
        
        X = pd.concat([X, ingredients_df], axis=1)
        
        y_recipe = self.label_encoder_recipe.fit_transform(df_copy['recipe_name'])
        y_cooking = self.label_encoder_cooking.fit_transform(df_copy['cooking_method'])
        
        return X, y_recipe, y_cooking
    
    def train(self, file_path):
        df = pd.read_csv(file_path)
        X, y_recipe, y_cooking = self.preprocess_data(df)
        
        X_scaled = self.scaler.fit_transform(X)
        
        self.knn_recipe.fit(X_scaled, y_recipe)
        self.knn_cooking.fit(X_scaled, y_cooking)
    
    def predict(self, breed, ingredients):
        breed_encoded = self.label_encoder_breed.transform([breed])
        ingredients_vectorized = self.ingredient_vectorizer.transform([ingredients])
        
        X_pred = pd.DataFrame({'breed_encoded': breed_encoded[0]}, index=[0])
        ingredients_df = pd.DataFrame(ingredients_vectorized.toarray(), 
                                      columns=self.ingredient_vectorizer.get_feature_names_out())
        X_pred = pd.concat([X_pred, ingredients_df], axis=1)
        
        # Ensure all columns from training are present, fill with 0 if missing
        missing_cols = set(self.scaler.feature_names_in_) - set(X_pred.columns)
        for col in missing_cols:
            X_pred[col] = 0
        
        # Reorder columns to match training data
        X_pred = X_pred[self.scaler.feature_names_in_]
        
        X_pred_scaled = self.scaler.transform(X_pred)
        
        recipe_pred = self.knn_recipe.predict(X_pred_scaled)
        cooking_pred = self.knn_cooking.predict(X_pred_scaled)
        
        recipe = self.label_encoder_recipe.inverse_transform(recipe_pred)[0]
        cooking_method = self.label_encoder_cooking.inverse_transform(cooking_pred)[0]
        
        return recipe, cooking_method
    
    def save_model(self, filename):
        joblib.dump(self, filename)
    
    @staticmethod
    def load_model(filename):
        return joblib.load(filename)

# Training code (to be run separately)
if __name__ == "__main__":
    model = PetFoodModel()
    model.train('indian_pet_food_db.recipes.csv')
    model.save_model('pet_food_model.joblib')