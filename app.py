# import pandas as pd
# import numpy as np
# from sklearn.preprocessing import StandardScaler, OneHotEncoder
# from sklearn.cluster import KMeans
# from flask import Flask, request, jsonify
# from flask_cors import CORS
# import pandas as pd
# import random

# app = Flask(__name__)
# CORS(app)
# # Load dataset
# file_path = "C://Users//aniru//Desktop//project//sparnet//sparnet//lib//backend//dataset.xlsx"  # Update this to the correct path on your machine
# df = pd.read_excel(file_path)

# # Encode categorical features (Category)
# encoder = OneHotEncoder()
# encoded_categories = encoder.fit_transform(df[['Category']]).toarray()

# # Normalize Price
# scaler = StandardScaler()
# df['Price_Norm'] = scaler.fit_transform(df[['Price']])

# # Combine features
# X = np.hstack((df[['Price_Norm']], encoded_categories))

# # Apply KMeans clustering
# num_clusters = 5
# kmeans = KMeans(n_clusters=num_clusters, random_state=42)
# df['Cluster'] = kmeans.fit_predict(X)

# # Recommend products based on current cart
# def recommend_products(cart_items, num_recommendations=5):
#     cart_clusters = df[df['Name'].isin(cart_items)]['Cluster'].unique()
#     recommendations = df[df['Cluster'].isin(cart_clusters) & ~df['Name'].isin(cart_items)]
#     return recommendations.sample(n=min(num_recommendations, len(recommendations)))

# # Example usage
# cart_items = ["Apple", "Milk"]
# recommended_products = recommend_products(cart_items)
# print(recommended_products[['Name', 'Category', 'Price']])

# @app.route('/random_products', methods=['GET'])
# def get_random_products():
#     try:
#         df = pd.read_excel("C://Users//aniru//Desktop//project//sparnet//sparnet//lib//backend//dataset.xlsx")

#         # Optional: Clean or rename columns if necessary
#         if 'Name' not in df.columns or 'Price' not in df.columns or 'Image Path' not in df.columns:
#             return jsonify({"error": "Required columns missing in Excel"}), 400

#         sample = df.sample(n=15).to_dict(orient='records')
#         return jsonify(sample), 200

#     except Exception as e:
#         return jsonify({"error": str(e)}), 500

# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=5004, debug=True)
import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.cluster import KMeans
from flask import Flask, request, jsonify
from flask_cors import CORS
import random

app = Flask(__name__)
CORS(app)

# Load dataset once
DATASET_PATH = "C://Users//aniru//Desktop//project//sparnet//sparnet//lib//backend//dataset.xlsx"
df = pd.read_excel(DATASET_PATH)

# Check for required columns
required_columns = {'Name', 'Category', 'Price', 'Image Path'}
if not required_columns.issubset(df.columns):
    raise Exception(f"Missing required columns in Excel: {required_columns - set(df.columns)}")

# Preprocessing
encoder = OneHotEncoder()
encoded_categories = encoder.fit_transform(df[['Category']]).toarray()

scaler = StandardScaler()
df['Price_Norm'] = scaler.fit_transform(df[['Price']])

X = np.hstack((df[['Price_Norm']], encoded_categories))

# KMeans Clustering
num_clusters = 5
kmeans = KMeans(n_clusters=num_clusters, random_state=42)
df['Cluster'] = kmeans.fit_predict(X)

# Recommendation Logic
def recommend_products(cart_items, num_recommendations=5):
    cart_clusters = df[df['Name'].isin(cart_items)]['Cluster'].unique()
    recommendations = df[df['Cluster'].isin(cart_clusters) & ~df['Name'].isin(cart_items)]
    return recommendations.sample(n=min(num_recommendations, len(recommendations)))

# Endpoint: Get 15 Random Products
@app.route('/random_products', methods=['GET'])
def get_random_products():
    try:
        sample = df.sample(n=min(15, len(df))).to_dict(orient='records')
        return jsonify(sample), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Example route: Get recommendations based on cart (optional)
@app.route('/recommend', methods=['POST'])
def recommend_from_cart():
    try:
        data = request.get_json()
        cart_items = data.get('ingredients', [])
        recommended_df = recommend_products(cart_items)
        return jsonify(recommended_df.to_dict(orient='records')), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# @app.route("/get_product_by_barcode/<barcode>", methods=["GET"])
# def get_product_by_barcode(barcode):
#     barcode = barcode.strip()[:12]  # Only take first 12 digits
#     df["Barcode"] = df["Barcode"].astype(str).str.strip()

#     item = df[df["Barcode"] == barcode]
#     if item.empty:
#         return jsonify({"error": "Product not found"}), 404

#     return jsonify(item.iloc[0].to_dict()), 200

@app.route("/get_product_by_barcode/<barcode>", methods=["GET"])
def get_product_by_barcode(barcode):
    barcode = barcode.strip()[:12]  # Ensuring 12-digit match
    df["Barcode"] = df["Barcode"].astype(str).str.strip()
    item = df[df["Barcode"] == barcode]

    if item.empty:
        return jsonify({"error": "Product not found"}), 404

    return jsonify(item.iloc[0].to_dict()), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5004, debug=True)
