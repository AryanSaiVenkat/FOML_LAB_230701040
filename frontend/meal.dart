// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MaterialApp(home: MealSuggestionPage()));
// }

// class MealSuggestionPage extends StatefulWidget {
//   @override
//   _MealSuggestionPageState createState() => _MealSuggestionPageState();
// }

// class _MealSuggestionPageState extends State<MealSuggestionPage> {
//   List<String> recommendedIngredients = [];
//   List<dynamic> meals = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchRecommendations();
//   }

//   Future<void> fetchRecommendations() async {
//     final response = await http.post(
//       Uri.parse('http://192.168.1.34:5005/recommend'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'ingredients': ['Potato', 'Ghee', 'Mustard Seeds'],
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       setState(() {
//         recommendedIngredients = List<String>.from(
//           data['recommended_ingredients'],
//         );
//         meals = data['meals'];
//       });
//     } else {
//       print('Error: ${response.statusCode}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFCEEAD7),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Top Header with Centered Title & Image
//             Stack(
//               children: [
//                 Container(
//                   height: 210, // increased height
//                   width: double.infinity,
//                   color: const Color(0xFF276348),
//                 ),
//                 Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     const Center(
//                       child: Text(
//                         "Meal Recommendation",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontFamily: 'Poppins',
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Center(
//                       child: Image.asset(
//                         'assets/nutrition_planner.png',
//                         width: 240,
//                         height: 240,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),

//             // Content Section
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       // Ingredients Text - Centered
//                       const Center(
//                         child: Text(
//                           "Ingredients, you can also consider adding:",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontFamily: 'Poppins',
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),

//                       // Ingredient Cards (Horizontal Scroll)
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: recommendedIngredients
//                               .map(
//                                 (item) => Container(
//                                   margin: const EdgeInsets.only(right: 10),
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 20,
//                                     vertical: 14,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(16),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                         color: Colors.black12,
//                                         blurRadius: 4,
//                                         offset: Offset(2, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Text(
//                                     item,
//                                     style: const TextStyle(
//                                       fontFamily: 'Poppins',
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                 ),
//                               )
//                               .toList(),
//                         ),
//                       ),

//                       const SizedBox(height: 16),

//                       // Meal Section Header with Dividers
//                       const Row(
//                         children: [
//                           Expanded(
//                             child: Divider(thickness: 1, color: Colors.black26),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 8),
//                             child: Text(
//                               "Smart Meal Suggestions",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Divider(thickness: 1, color: Colors.black26),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 16),

//                       // Recommended Meals (Vertical Scroll)
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: meals.length,
//                         itemBuilder: (context, index) {
//                           final meal = meals[index];
//                           return Container(
//                             margin: const EdgeInsets.only(bottom: 12),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(16),
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: Colors.black12,
//                                   blurRadius: 4,
//                                   offset: Offset(2, 2),
//                                 ),
//                               ],
//                             ),
//                             child: ExpansionTile(
//                               title: Text(
//                                 meal['Dish_Name'] ?? '',
//                                 style: const TextStyle(
//                                   fontFamily: 'Poppins',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               children: [
//                                 const Divider(
//                                     thickness: 2, color: Colors.black26),
//                                 if (meal['Calories'] != null)
//                                   ListTile(
//                                     title: Text(
//                                       "Calories: ${meal['Calories']}",
//                                     ),
//                                   ),
//                                 if (meal['Proteins'] != null)
//                                   ListTile(
//                                     title: Text(
//                                       "Proteins: ${meal['Proteins']}",
//                                     ),
//                                   ),
//                                 if (meal['Carbohydrates (g)'] != null)
//                                   ListTile(
//                                     title: Text(
//                                       "Carbs: ${meal['Carbohydrates (g)']}",
//                                     ),
//                                   ),
//                                 if (meal['Fats (g)'] != null)
//                                   ListTile(
//                                     title: Text("Fats: ${meal['Fats (g)']}"),
//                                   ),
//                                 if (meal['Fiber (g)'] != null)
//                                   ListTile(
//                                     title: Text("Fiber: ${meal['Fiber (g)']}"),
//                                   ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MealSuggestionPage extends StatefulWidget {
  final String phoneNumber;
  const MealSuggestionPage({super.key, required this.phoneNumber});

  @override
  _MealSuggestionPageState createState() => _MealSuggestionPageState();
}

class _MealSuggestionPageState extends State<MealSuggestionPage> {
  List<String> recommendedIngredients = [];
  List<dynamic> meals = [];

  @override
  void initState() {
    super.initState();
    fetchCartAndRecommend();
  }

  Future<void> fetchCartAndRecommend() async {
    try {
      // Step 1: Fetch cart items
      final cartUrl =
          Uri.parse('http://192.168.213.31:5000/cart/${widget.phoneNumber}');
      final cartResponse = await http.get(cartUrl);

      if (cartResponse.statusCode != 200) {
        print('❌ Error fetching cart: ${cartResponse.body}');
        return;
      }

      final cartData = jsonDecode(cartResponse.body);
      final List<dynamic> cartItems = cartData['cart'];
      final List<String> ingredientList =
          cartItems.map((item) => item['name'].toString()).toList();

      print('🛒 Cart items used as ingredients: $ingredientList');

      // Step 2: Send those items to recommendation engine
      final recommendUrl = Uri.parse('http://192.168.213.31:5005/recommend');
      final recommendResponse = await http.post(
        recommendUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'ingredients': ingredientList}),
      );

      if (recommendResponse.statusCode == 200) {
        final recommendationData = jsonDecode(recommendResponse.body);
        print('✅ Recommendation API response: $recommendationData');
        setState(() {
          recommendedIngredients =
              List<String>.from(recommendationData['recommended_ingredients']);
          meals = recommendationData['meals'];
        });
      } else {
        print('❌ Recommendation error: ${recommendResponse.body}');
      }
    } catch (e) {
      print('❗ Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCEEAD7),
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Stack(
              children: [
                Container(
                  height: 210,
                  width: double.infinity,
                  color: const Color(0xFF276348),
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        "Meal Recommendation",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Image.asset(
                        'assets/nutrition_planner.png',
                        width: 240,
                        height: 240,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Body content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "Ingredients, you can also consider adding:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Ingredient cards
                      recommendedIngredients.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "No suggestions available.",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: recommendedIngredients
                                    .map((item) => Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 14),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                offset: Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 15,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),

                      const SizedBox(height: 16),

                      // Meals section header
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.black26),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Smart Meal Suggestions",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.black26),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Recommended meals
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: meals.length,
                        itemBuilder: (context, index) {
                          final meal = meals[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: ExpansionTile(
                              title: Text(
                                meal['Dish_Name'] ?? '',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              children: [
                                const Divider(
                                    thickness: 2, color: Colors.black26),
                                if (meal['Calories'] != null)
                                  ListTile(
                                      title: Text(
                                          "Calories: ${meal['Calories']}")),
                                if (meal['Proteins'] != null)
                                  ListTile(
                                      title: Text(
                                          "Proteins: ${meal['Proteins']}")),
                                if (meal['Carbohydrates (g)'] != null)
                                  ListTile(
                                      title: Text(
                                          "Carbs: ${meal['Carbohydrates (g)']}")),
                                if (meal['Fats (g)'] != null)
                                  ListTile(
                                      title: Text("Fats: ${meal['Fats (g)']}")),
                                if (meal['Fiber (g)'] != null)
                                  ListTile(
                                      title:
                                          Text("Fiber: ${meal['Fiber (g)']}")),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
