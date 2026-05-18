from flask import Flask, request, jsonify
import pandas as pd
from mlxtend.frequent_patterns import apriori, association_rules
from mlxtend.preprocessing import TransactionEncoder

app = Flask(__name__)

# ==================== Load and Prepare Data ====================
# Load recipe dataset
recipe_df = pd.read_excel("Combined_Indian_Recipes.xlsx")
recipe_df.rename(columns={'Main Ingredients': 'Ingredients', 'Dish': 'Dish_Name'}, inplace=True)
recipe_df["Ingredients"] = recipe_df["Ingredients"].apply(lambda x: x.split(", "))

# Load nutritional dataset
nutrition_df = pd.read_excel("Dish_Nutritional_Info_Fiber_Updated.xlsx")
nutrition_df.rename(columns={'Dish': 'Dish_Name'}, inplace=True)

# Merge recipe and nutrition datasets
full_recipe_df = pd.merge(recipe_df, nutrition_df, on='Dish_Name', how='left')

# Convert transactions into a list
transactions = recipe_df["Ingredients"].tolist()

# Encode transactions for Apriori
te = TransactionEncoder()
te_ary = te.fit(transactions).transform(transactions)
df_encoded = pd.DataFrame(te_ary, columns=te.columns_)

# Apply Apriori and get association rules
frequent_itemsets = apriori(df_encoded, min_support=0.1, use_colnames=True)
rules = association_rules(frequent_itemsets, metric="confidence", min_threshold=0.5)

# ==================== Logic Functions ====================
def recommend_ingredients(input_ingredients, rules_df):
    """
    Recommends additional ingredients based on association rules.
    """
    recommended_ingredients = set()
    for ingredient in input_ingredients:
        matching_rules = rules_df[rules_df["antecedents"].apply(lambda x: ingredient in x)]
        for _, row in matching_rules.iterrows():
            recommended_ingredients.update(row["consequents"])
    return list(recommended_ingredients - set(input_ingredients))


def get_meal_recommendations(input_ingredients, recommended_ingredients, recipe_df, nutrition_df):
    """
    Finds meals that contain the most input and recommended ingredients and returns the top 2-3 matches.
    """
    combined_ingredients = set(input_ingredients + recommended_ingredients)

    # Calculate match count
    recipe_df["Match_Count"] = recipe_df["Ingredients"].apply(lambda x: len(set(x) & combined_ingredients))

    # Ensure at least half the input ingredients are matched
    top_meals = recipe_df[recipe_df["Match_Count"] >= len(input_ingredients) // 2]
    top_meals = top_meals.sort_values(by="Match_Count", ascending=False).head(3)

    return top_meals.merge(nutrition_df, on='Dish_Name', how='left')

# ==================== Flask API Endpoint ====================
@app.route('/recommend', methods=['POST'])
def recommend():
    ingredients = request.json.get("ingredients", [])
    recommended = recommend_ingredients(ingredients, rules)
    meals_df = get_meal_recommendations(ingredients, recommended, recipe_df, nutrition_df)

    # Convert result to JSON
    meals = meals_df.to_dict(orient="records")
    return jsonify({
        "recommended_ingredients": recommended,
        "meals": meals
    })

# ==================== Run Flask App ====================
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5005, debug=True)