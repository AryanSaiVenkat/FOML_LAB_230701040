
import matplotlib.pyplot as plt
from collections import Counter

ingredient_counts = Counter([item for sublist in transactions for item in sublist])
top_ingredients = ingredient_counts.most_common(20)

ingredients, counts = zip(*top_ingredients)
plt.figure(figsize=(10,6))
plt.barh(ingredients[::-1], counts[::-1], color='skyblue')
plt.title("Top 20 Most Common Ingredients")
plt.xlabel("Frequency")
plt.tight_layout()
plt.show()



if __name__ == "__main__":
    plt.show()
