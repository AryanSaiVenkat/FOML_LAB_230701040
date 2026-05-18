// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:sparnet/frontend/cart.dart';
// import 'package:sparnet/frontend/meal.dart';
// import 'dart:convert';

// import 'package:sparnet/frontend/scanner.dart';

// class HomeScreen extends StatefulWidget {
//   final String phoneNumber;
//   const HomeScreen({super.key, required this.phoneNumber});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String userName = "Loading...";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFCEEAD7),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _headerSection(context),
//             const SizedBox(height: 10),
//             _searchBar(),
//             const SizedBox(height: 20),
//             _sectionTitle("Recommendations"),
//             const SizedBox(height: 10),
//             _horizontalList(4),
//             const SizedBox(height: 20),
//             _adsSection(),
//             const SizedBox(height: 20),
//             _sectionTitle("Products"),
//             const SizedBox(height: 10),
//             _recommendationSection(),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _bottomNavBar(context),
//     );
//   }

//   List<Map<String, String>> allItems = [
//     {
//       "name": "Apples",
//       "description": "Fresh red apples rich in fiber and antioxidants.",
//       "image": "assets/apples.png",
//       "price": "₹60"
//     },
//     {
//       "name": "Banana",
//       "description": "High-energy fruit packed with potassium and vitamins.",
//       "image": "assets/banana.png",
//       "price": "₹40"
//     },
//     {
//       "name": "Chili",
//       "description": "Spicy ingredient used in Indian cuisine.",
//       "image": "assets/chili.png",
//       "price": "₹25"
//     },
//     {
//       "name": "Eggplant",
//       "description": "Also known as brinjal, used in many Indian dishes.",
//       "image": "assets/eggplant.png",
//       "price": "₹30"
//     },
//     {
//       "name": "Garlic",
//       "description": "Used in cooking and known for medicinal properties.",
//       "image": "assets/garlic.png",
//       "price": "₹50"
//     },
//     {
//       "name": "Ginger",
//       "description": "Aromatic root used in teas, curries, and medicine.",
//       "image": "assets/ginger.png",
//       "price": "₹45"
//     },
//     {
//       "name": "Grapes",
//       "description": "Small and juicy, available in green and black varieties.",
//       "image": "assets/grapes.png",
//       "price": "₹70"
//     },
//     {
//       "name": "Green Peas",
//       "description": "Sweet and nutritious, used in curries and rice dishes.",
//       "image": "assets/greenpea.png",
//       "price": "₹55"
//     },
//     {
//       "name": "Guava",
//       "description": "Nutrient-rich fruit known for boosting immunity.",
//       "image": "assets/guava.png",
//       "price": "₹35"
//     },
//     {
//       "name": "Mango",
//       "description": "Sweet and juicy, the king of fruits in India.",
//       "image": "assets/mango.png",
//       "price": "₹90"
//     },
//     {
//       "name": "Papaya",
//       "description": "Rich in enzymes aiding digestion and skin health.",
//       "image": "assets/papaya.png",
//       "price": "₹50"
//     },
//     {
//       "name": "Pineapple",
//       "description": "Tropical fruit with a tangy and sweet taste.",
//       "image": "assets/pineapple.png",
//       "price": "₹80"
//     },
//     {
//       "name": "Pomegranate",
//       "description": "Rich in antioxidants and nutrients, great for health.",
//       "image": "assets/pomegranate.png",
//       "price": "₹100"
//     },
//     {
//       "name": "Rice",
//       "description": "Staple grain, used in various dishes across India.",
//       "image": "assets/rice.png",
//       "price": "₹45"
//     },
//     {
//       "name": "Salt",
//       "description": "Essential seasoning for all types of cooking.",
//       "image": "assets/salt.png",
//       "price": "₹20"
//     },
//     {
//       "name": "Sugar",
//       "description": "Sweetener used in tea, sweets, and desserts.",
//       "image": "assets/sugar.png",
//       "price": "₹30"
//     },
//     {
//       "name": "Turmeric Powder",
//       "description": "Spice known for its color and medicinal benefits.",
//       "image": "assets/turmeric.png",
//       "price": "₹40"
//     },
//     {
//       "name": "Watermelon",
//       "description": "Hydrating fruit with a sweet and refreshing taste.",
//       "image": "assets/watermelon.png",
//       "price": "₹60"
//     },
//     {
//       "name": "Wheat Flour",
//       "description": "Used to make chapatis and other Indian breads.",
//       "image": "assets/wheat.png",
//       "price": "₹35"
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     fetchUserName();
//   }

//   Future<void> fetchUserName() async {
//     //final String apiUrl = "http://192.168.1.18:5000/user/${widget.phoneNumber}";
//     // final String apiUrl =
//     //     "http://192.168.183.31:5000/user/${widget.phoneNumber}";
//     final String apiUrl = "http://192.168.1.34:5000/user/${widget.phoneNumber}";

//     try {
//       final response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           userName = data['user']['name'];
//         });
//       } else {
//         setState(() {
//           userName = "User Not Found";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         userName = "Error fetching name";
//       });
//       print("Error fetching user name: $e");
//     }
//   }

//   Future<void> saveItemToDatabase(Map<String, String> item) async {
//     //final url = Uri.parse('http://192.168.1.18:5000/add_item');
//     // final url = Uri.parse('http://192.168.183.31:5000/add_item');
//     final url = Uri.parse('http://192.168.1.34:5000/add_item');
//     final priceValue = item['price']!.replaceAll(RegExp(r'[^0-9.]'), '');

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'phone': widget.phoneNumber, // ✅ Include the phone number here
//           'name': item['name'],
//           'description': item['description'],
//           'price': double.tryParse(priceValue) ?? 0.0,
//         }),
//       );

//       if (response.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Item added to database!")),
//         );
//       } else {
//         print("Failed response: ${response.body}"); // helpful for debugging
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Failed to add item.")),
//         );
//       }
//     } catch (e) {
//       print("Error adding item: $e");
//     }
//   }

//   Widget _text(String text, double size, Color color, FontWeight weight,
//       {bool italic = false}) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontSize: size,
//         color: color,
//         fontWeight: weight,
//         fontFamily: 'Poppins',
//         fontStyle: italic ? FontStyle.italic : FontStyle.normal,
//       ),
//     );
//   }

//   Widget _recommendationSection() {
//     return SizedBox(
//       height: 160,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: allItems.length,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         itemBuilder: (context, index) {
//           final item = allItems[index];
//           return Container(
//             width: 130,
//             margin: const EdgeInsets.only(right: 12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 5,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Stack(
//               children: [
//                 Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(item['image']!, height: 60),
//                       const SizedBox(height: 8),
//                       _text(item['name']!, 14, Colors.black, FontWeight.bold),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   right: 6,
//                   top: 6,
//                   child: GestureDetector(
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(16)),
//                             content: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Image.asset(item['image']!, height: 100),
//                                 const SizedBox(height: 10),
//                                 _text(item['name']!, 18, Colors.black,
//                                     FontWeight.bold),
//                                 const SizedBox(height: 12),
//                                 Center(
//                                   child: _text(
//                                     item['description']!,
//                                     14,
//                                     Colors.black,
//                                     FontWeight.normal,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     _text(item['price']!, 16, Colors.black,
//                                         FontWeight.bold),
//                                     ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Color(0xFF2F9050),
//                                       ),
//                                       onPressed: () async {
//                                         Navigator.pop(context);
//                                         await saveItemToDatabase(item);
//                                       },
//                                       child: const Text("Add",
//                                           style:
//                                               TextStyle(color: Colors.white)),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     child: const Icon(Icons.add_circle, color: Colors.green),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _headerSection(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
//       color: const Color(0xFF2F9050),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: () => Navigator.pushNamed(context, '/profilePage'),
//                 child: const CircleAvatar(
//                   radius: 30,
//                   backgroundImage: AssetImage('assets/profile.png'),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _text("Welcome", 18, Colors.white, FontWeight.normal),
//                   _text(userName, 20, Colors.white, FontWeight.bold),
//                 ],
//               ),
//               const Spacer(),
//               GestureDetector(
//                 onTap: () => Navigator.pushNamed(context, '/notifications'),
//                 child: const Icon(Icons.notifications, color: Colors.white),
//               ),
//               const SizedBox(width: 16),
//               GestureDetector(
//                 onTap: () => Navigator.pushNamed(context, '/sidebar'),
//                 child: const Icon(Icons.menu, color: Colors.white),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.3),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Center(
//               child: _text("Shopping just made effortless", 14, Colors.white,
//                   FontWeight.w500,
//                   italic: true),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _searchBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//         height: 50,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(30),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 5,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: const Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: "Search",
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//             Icon(Icons.search, color: Colors.grey),
//             SizedBox(width: 8),
//             Icon(Icons.mic, color: Colors.pink),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _sectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children: [
//           Expanded(
//             child: Divider(
//               color: Colors.black.withOpacity(0.3),
//               thickness: 1.9,
//               endIndent: 10,
//             ),
//           ),
//           _text(title, 18, Colors.black, FontWeight.bold),
//           Expanded(
//             child: Divider(
//               color: Colors.black.withOpacity(0.3),
//               thickness: 1.9,
//               indent: 10,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _horizontalList(int itemCount) {
//     return SizedBox(
//       height: 120,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: itemCount,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         itemBuilder: (context, index) {
//           return Container(
//             width: 100,
//             margin: const EdgeInsets.only(right: 12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 5,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _adsSection() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       height: 80,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Center(
//         child: _text("ADS", 16, Colors.black, FontWeight.normal),
//       ),
//     );
//   }

//   Widget _bottomNavItem(BuildContext context, IconData icon, Widget screen,
//       {bool isHighlighted = false}) {
//     return IconButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => screen),
//         );
//       },
//       icon: Icon(
//         icon,
//         color: Colors.white,
//         size: isHighlighted ? 35 : 30,
//       ),
//     );
//   }

// //   Widget _bottomNavBar(BuildContext context) {
// //     return Container(
// //       height: 70,
// //       decoration: const BoxDecoration(
// //         color: Color(0xFF2F9050),
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
// //       ),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //         children: [
// //           _bottomNavItem(
// //             context,
// //             Icons.set_meal_outlined,
// //             HomeScreen(phoneNumber: widget.phoneNumber),
// //           ),
// //           _bottomNavItem(
// //             context,
// //             Icons.qr_code_scanner,
// //             ScannerPage(phoneNumber: widget.phoneNumber),
// //             isHighlighted: true,
// //           ),
// //           _bottomNavItem(
// //             context,
// //             Icons.shopping_cart,
// //             CartScreen(phoneNumber: widget.phoneNumber),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

//   Widget _bottomNavBar(BuildContext context) {
//     return Container(
//       height: 70,
//       decoration: const BoxDecoration(
//         color: Color(0xFF2F9050),
//         borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _bottomNavItem(
//             context,
//             Icons.set_meal_outlined,
//             MealSuggestionPage(
//                 phoneNumber: widget.phoneNumber), // ✅ Updated target
//           ),
//           _bottomNavItem(
//             context,
//             Icons.qr_code_scanner,
//             ScannerPage(phoneNumber: widget.phoneNumber),
//             isHighlighted: true,
//           ),
//           _bottomNavItem(
//             context,
//             Icons.shopping_cart,
//             CartScreen(phoneNumber: widget.phoneNumber),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sparnet/frontend/cart.dart';
import 'package:sparnet/frontend/meal.dart';
import 'package:sparnet/frontend/scanner.dart';

class HomeScreen extends StatefulWidget {
  final String phoneNumber;
  const HomeScreen({super.key, required this.phoneNumber});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "Loading...";
  List<Map<String, dynamic>> allItems = [];
  List<Map<String, dynamic>> recommendedItems = [];
  @override
  void initState() {
    super.initState();
    fetchUserName();
    fetchRandomItems();
    fetchRecommendedItems();
  }

  Widget _recommendationCardList() {
    if (recommendedItems.isEmpty) {
      return const Center(child: Text("No recommendations available"));
    }

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendedItems.length,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          final item = recommendedItems[index];
          return Container(
            width: 130,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          item['Image Path'] ?? 'assets/placeholder.png',
                          height: 60),
                      const SizedBox(height: 8),
                      _text(item['Name'] ?? '', 14, Colors.black,
                          FontWeight.bold),
                    ],
                  ),
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                    item['Image Path'] ??
                                        'assets/placeholder.png',
                                    height: 100),
                                const SizedBox(height: 10),
                                _text(item['Name'] ?? '', 18, Colors.black,
                                    FontWeight.bold),
                                const SizedBox(height: 12),
                                Center(
                                  child: _text(
                                    item['Detail'] ?? 'No description',
                                    14,
                                    Colors.black,
                                    FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _text("₹${item['Price'].toString()}", 16,
                                        Colors.black, FontWeight.bold),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF2F9050),
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        await saveItemToDatabase(item);
                                      },
                                      child: const Text("Add",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.add_circle, color: Colors.green),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> fetchRecommendedItems() async {
    final cartUrl =
        Uri.parse('http://192.168.213.31:5000/cart/${widget.phoneNumber}');
    final recommendUrl = Uri.parse('http://192.168.213.31:5006/recommend_v2');

    try {
      // Step 1: Get cart items
      final cartResponse = await http.get(cartUrl);
      if (cartResponse.statusCode != 200) {
        print("Failed to fetch cart: ${cartResponse.body}");
        return;
      }

      final cartData = jsonDecode(cartResponse.body);
      final List<dynamic> cartItems = cartData['cart'];

      // Step 2: Extract product names
      final List<String> ingredients =
          cartItems.map((item) => item['name'].toString()).toList();

      print("🛒 Cart ingredients used for recommendations: $ingredients");

      // Step 3: Get recommendations
      final recommendResponse = await http.post(
        recommendUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'ingredients': ingredients}),
      );

      if (recommendResponse.statusCode == 200) {
        final data = jsonDecode(recommendResponse.body);
        setState(() {
          recommendedItems =
              List<Map<String, dynamic>>.from(data['recommended_items']);
        });
      } else {
        print("❌ Failed to load recommendations: ${recommendResponse.body}");
      }
    } catch (e) {
      print("❌ Error fetching recommended items: $e");
    }
  }

  Future<void> fetchUserName() async {
    final String apiUrl =
        "http://192.168.213.31:5000/user/${widget.phoneNumber}";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          userName = data['user']['name'];
        });
      } else {
        setState(() {
          userName = "User Not Found";
        });
      }
    } catch (e) {
      setState(() {
        userName = "Error fetching name";
      });
      print("Error fetching user name: $e");
    }
  }

  Future<void> fetchRandomItems() async {
    final url = Uri.parse('http://192.168.213.31:5004/random_products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> items = jsonDecode(response.body);
        setState(() {
          allItems = List<Map<String, dynamic>>.from(items);
        });
      } else {
        print("Failed to load random products: ${response.body}");
      }
    } catch (e) {
      print("Error fetching random products: $e");
    }
  }

  Future<void> saveItemToDatabase(Map<String, dynamic> item) async {
    final url = Uri.parse('http://192.168.213.31:5000/add_item');
    final priceValue =
        item['Price'].toString().replaceAll(RegExp(r'[^0-9.]'), '');
    print("Sending item to DB: ${jsonEncode({
          'phone': widget.phoneNumber,
          'name': item['Name'],
          'description': item['Detail'] ?? '',
          'price': double.tryParse(priceValue) ?? 0.0,
          'imagePath': (item['Image Path'] ??
                  item['imagePath'] ??
                  item['Img'] ??
                  'assets/placeholder.png')
              .toString(),
        })}");
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': widget.phoneNumber,
          'name': item['Name'],
          'description': item['Detail'] ?? '',
          'price': double.tryParse(priceValue) ?? 0.0,
          'imagePath': (item['Image Path'] ??
                  item['imagePath'] ??
                  item['Img'] ??
                  'assets/placeholder.png')
              .toString(), // ✅ Added
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Item added to database!")),
        );
      } else {
        print("Failed response: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to add item.")),
        );
      }
    } catch (e) {
      print("Error adding item: $e");
    }
  }

  Widget _text(String text, double size, Color color, FontWeight weight,
      {bool italic = false}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
        fontFamily: 'Poppins',
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }

  Widget _recommendationSection() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allItems.length,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          final item = allItems[index];
          return Container(
            width: 130,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          item['Image Path'] ?? 'assets/placeholder.png',
                          height: 60),
                      const SizedBox(height: 8),
                      _text(item['Name'] ?? '', 14, Colors.black,
                          FontWeight.bold),
                    ],
                  ),
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                    item['Image Path'] ??
                                        'assets/placeholder.png',
                                    height: 100),
                                const SizedBox(height: 10),
                                _text(item['Name'] ?? '', 18, Colors.black,
                                    FontWeight.bold),
                                const SizedBox(height: 12),
                                Center(
                                  child: _text(
                                    item['Detail'] ?? 'No description',
                                    14,
                                    Colors.black,
                                    FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _text("₹${item['Price'].toString()}", 16,
                                        Colors.black, FontWeight.bold),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF2F9050),
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        await saveItemToDatabase(item);
                                      },
                                      child: const Text("Add",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.add_circle, color: Colors.green),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      color: const Color(0xFF2F9050),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/profilePage'),
                child: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _text("Welcome", 18, Colors.white, FontWeight.normal),
                  _text(userName, 20, Colors.white, FontWeight.bold),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/notifications'),
                child: const Icon(Icons.notifications, color: Colors.white),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/sidebar'),
                child: const Icon(Icons.menu, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: _text("Shopping just made effortless", 14, Colors.white,
                  FontWeight.w500,
                  italic: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  border: InputBorder.none,
                ),
              ),
            ),
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8),
            Icon(Icons.mic, color: Colors.pink),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.black.withOpacity(0.3),
              thickness: 1.9,
              endIndent: 10,
            ),
          ),
          _text(title, 18, Colors.black, FontWeight.bold),
          Expanded(
            child: Divider(
              color: Colors.black.withOpacity(0.3),
              thickness: 1.9,
              indent: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _horizontalList(int itemCount) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _adsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: _text("ADS", 16, Colors.black, FontWeight.normal),
      ),
    );
  }

  Widget _bottomNavItem(BuildContext context, IconData icon, Widget screen,
      {bool isHighlighted = false}) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      icon: Icon(
        icon,
        color: Colors.white,
        size: isHighlighted ? 35 : 30,
      ),
    );
  }

  Widget _bottomNavBar(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFF2F9050),
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _bottomNavItem(
            context,
            Icons.set_meal_outlined,
            MealSuggestionPage(phoneNumber: widget.phoneNumber),
          ),
          _bottomNavItem(
            context,
            Icons.qr_code_scanner,
            ScannerPage(phoneNumber: widget.phoneNumber),
            isHighlighted: true,
          ),
          _bottomNavItem(
            context,
            Icons.shopping_cart,
            CartScreen(phoneNumber: widget.phoneNumber),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCEEAD7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _headerSection(context),
            const SizedBox(height: 10),
            _searchBar(),
            const SizedBox(height: 20),
            _sectionTitle("Recommendations"),
            const SizedBox(height: 10),
            _recommendationCardList(),
            const SizedBox(height: 20),
            _adsSection(),
            const SizedBox(height: 20),
            _sectionTitle("Products"),
            const SizedBox(height: 10),
            _recommendationSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavBar(context),
    );
  }
}
