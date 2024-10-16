import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.preprocessing import LabelEncoder
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler
import joblib
import numpy as np

class PetFoodModel:
    def __init__(self):
        self.label_encoder_breed = LabelEncoder()
        self.label_encoder_ingredients = LabelEncoder()
        self.label_encoder_recipe = LabelEncoder()
        self.label_encoder_cooking = LabelEncoder()
        self.knn_recipe = make_pipeline(StandardScaler(), KNeighborsClassifier(n_neighbors=5))
        self.knn_cooking = make_pipeline(StandardScaler(), KNeighborsClassifier(n_neighbors=5))
    
    def preprocess_data(self, df):
        df_copy = df.copy()
        
        df_copy['ingredients_combined'] = df_copy[['ingredients[0].name', 'ingredients[1].name',
                                                   'ingredients[2].name', 'ingredients[3].name',
                                                   'ingredients[4].name', 'ingredients[5].name']].fillna('').agg(' '.join, axis=1)
        
        X = pd.DataFrame()
        X['breed'] = df_copy['breed']
        X['ingredients_combined'] = df_copy['ingredients_combined']
        
        y_recipe = df_copy['recipe_name']
        y_cooking = df_copy['cooking_method']

        X['breed_encoded'] = self.label_encoder_breed.fit_transform(X['breed'])
        X['ingredients_encoded'] = self.label_encoder_ingredients.fit_transform(X['ingredients_combined'])
        X_encoded = X[['breed_encoded', 'ingredients_encoded']]

        y_recipe_encoded = self.label_encoder_recipe.fit_transform(y_recipe)
        y_cooking_encoded = self.label_encoder_cooking.fit_transform(y_cooking)

        return X_encoded, y_recipe_encoded, y_cooking_encoded
    
    def train(self, file_path):
        df = pd.read_csv(file_path)
        X_encoded, y_recipe_encoded, y_cooking_encoded = self.preprocess_data(df)

        X_train, _, y_train_recipe, _, y_train_cooking, _ = train_test_split(
            X_encoded, y_recipe_encoded, y_cooking_encoded, test_size=0.2, random_state=42
        )

        self.knn_recipe.fit(X_train, y_train_recipe)
        self.knn_cooking.fit(X_train, y_train_cooking)
    
    def predict(self, breed, ingredients):
        try:
            breed_encoded = self.label_encoder_breed.transform([breed])
        except ValueError:
            breed_encoded = [-1]  # Use a placeholder value for unknown breeds
        
        try:
            ingredients_encoded = self.label_encoder_ingredients.transform([ingredients])
        except ValueError:
            ingredients_encoded = [-1]  # Use a placeholder value for unknown ingredients
        
        X_pred = pd.DataFrame({'breed_encoded': breed_encoded, 'ingredients_encoded': ingredients_encoded})

        recipe_pred = self.knn_recipe.predict(X_pred)
        cooking_pred = self.knn_cooking.predict(X_pred)

        recipe = self.label_encoder_recipe.inverse_transform(recipe_pred)[0]
        cooking_method = self.label_encoder_cooking.inverse_transform(cooking_pred)[0]

        return recipe, cooking_method
    
    def save_model(self, filename):
        joblib.dump(self, filename)
    
    @staticmethod
    def load_model(filename):
        return joblib.load(filename)

# The following code will only run if this script is executed directly
if __name__ == "__main__":
    model = PetFoodModel()
    model.train('./indian_pet_food_db.recipes.csv')
    model.save_model('pet_food_model.joblib')