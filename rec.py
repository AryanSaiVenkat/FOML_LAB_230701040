import pandas as pd
import numpy as np
from flask import Flask, request, jsonify
from flask_cors import CORS
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

app = Flask(__name__)
CORS(app)

# === Load Dataset ===
DATASET_PATH = "C://Users//aniru//Desktop//project//sparnet//sparnet//lib//backend//dataset.xlsx"
df = pd.read_excel(DATASET_PATH)

# Ensure all required columns exist
required_columns = {'Name', 'Category', 'Price', 'Detail'}
if not required_columns.issubset(df.columns):
    raise Exception(f"Missing required columns in Excel: {required_columns - set(df.columns)}")

# Fill any missing 'Detail' values with empty string
df['Detail'] = df['Detail'].fillna("")

# === Create Text Embeddings ===
vectorizer = TfidfVectorizer(stop_words='english')
tfidf_matrix = vectorizer.fit_transform(df['Detail'])

# === Cosine Similarity Matrix ===
cosine_sim = cosine_similarity(tfidf_matrix, tfidf_matrix)

# Helper function to get product index by name
def get_index_by_name(name):
    try:
        return df[df['Name'].str.lower() == name.lower()].index[0]
    except IndexError:
        return None

# === API: Recommend similar items ===
@app.route('/recommend_v2', methods=['POST'])
def recommend_similar_items():
    try:
        data = request.get_json()
        input_items = data.get("ingredients", [])

        if not input_items:
            return jsonify({"error": "No ingredients provided"}), 400

        # Get indices for valid items
        input_indices = [get_index_by_name(name) for name in input_items]
        input_indices = [i for i in input_indices if i is not None]

        if not input_indices:
            return jsonify({"error": "No matching items found in dataset"}), 404

        # Sum similarity vectors across all input items
        total_sim = np.sum(cosine_sim[input_indices], axis=0)

        # Create a DataFrame with scores
        sim_scores = list(enumerate(total_sim))
        sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)

        # Exclude input items and pick top 5
        recommended_indices = [i for i, _ in sim_scores if i not in input_indices][:10]

        # Return recommended items
        recommendations = df.iloc[recommended_indices].to_dict(orient='records')
        return jsonify({"recommended_items": recommendations})

    except Exception as e:
        return jsonify({"error": str(e)}), 500

# === Run the App ===
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5006, debug=True)
