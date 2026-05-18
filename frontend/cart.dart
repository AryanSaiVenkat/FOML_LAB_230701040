// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'dart:convert';
// import 'package:sparnet/frontend/bill.dart';

// class CartScreen extends StatefulWidget {
//   final String phoneNumber;
//   const CartScreen({super.key, required this.phoneNumber});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   List<Map<String, dynamic>> cartItems = [];
//   String promoCode = "";
//   bool promoApplied = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchCartItems();
//   }

//   String _getImagePath(String name) {
//     final sanitized = name.toLowerCase().replaceAll(' ', '_');
//     return 'assets/$sanitized.png';
//   }

//   Future<void> fetchCartItems() async {
//     final url =
//         Uri.parse('http://192.168.1.34:5000/cart/${widget.phoneNumber}');
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final List<dynamic> items = data['cart'];
//         setState(() {
//           cartItems = items
//               .map((item) => {
//                     'id': item['_id'],
//                     'name': item['name'],
//                     'price': item['price'],
//                     'quantity': 1,
//                   })
//               .toList();
//         });
//       } else {
//         print("Failed to load cart items: ${response.body}");
//       }
//     } catch (e) {
//       print("Error fetching cart items: $e");
//     }
//   }

//   void _increaseQuantity(int index) {
//     setState(() {
//       cartItems[index]['quantity']++;
//     });
//   }

//   void _decreaseQuantity(int index) {
//     setState(() {
//       if (cartItems[index]['quantity'] > 1) {
//         cartItems[index]['quantity']--;
//       }
//     });
//   }

//   void _removeItem(int index) async {
//     String id = cartItems[index]['id'];
//     final url = Uri.parse('http://192.168.1.34:5000/cart/delete/$id');
//     await http.delete(url);
//     setState(() {
//       cartItems.removeAt(index);
//     });
//   }

//   void _clearCart() async {
//     for (var item in cartItems) {
//       final url =
//           Uri.parse('http://192.168.1.34:5000/cart/delete/${item['id']}');
//       await http.delete(url);
//     }
//     setState(() {
//       cartItems.clear();
//     });
//   }

//   double _calculateTotal() {
//     return cartItems.fold(
//       0.0,
//       (sum, item) => sum + item['price'] * item['quantity'],
//     );
//   }

//   Widget _priceRow(String label, double value, {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label,
//               style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//                   fontFamily: 'Poppins')),
//           Text('₹${value.toStringAsFixed(2)}',
//               style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//                   color: const Color(0xFF2F9050),
//                   fontFamily: 'Poppins')),
//         ],
//       ),
//     );
//   }

//   Future<void> _startStripePayment() async {
//     try {
//       final totalAmount = ((_calculateTotal() * 1.18) * 100).round();

//       final response = await http.post(
//         Uri.parse('http://192.168.1.34:5000/create-payment-intent'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({'amount': totalAmount}),
//       );

//       final jsonResp = json.decode(response.body);
//       final clientSecret = jsonResp['clientSecret'];

//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: clientSecret,
//           merchantDisplayName: 'Sparnet Store',
//           style: ThemeMode.light,
//         ),
//       );

//       await Stripe.instance.presentPaymentSheet();

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("✅ Payment successful!")),
//       );

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) =>
//               BillReceiptPage(phoneNumber: widget.phoneNumber),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("❌ Payment failed: $e")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cartTotal = _calculateTotal();
//     final tax = cartTotal * 0.18;
//     final discount = promoApplied ? cartTotal * 0.2 : 0.0;
//     final total = cartTotal + tax - discount;

//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: const Color(0xFFD7F0D9),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Icon(Icons.arrow_back, size: 28),
//                   const Text(
//                     'Your Cart',
//                     style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: 'Poppins'),
//                   ),
//                   ElevatedButton(
//                     onPressed: _clearCart,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       'Empty Cart',
//                       style:
//                           TextStyle(color: Colors.white, fontFamily: 'Poppins'),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),

//             // Scrollable cart items
//             Expanded(
//               child: ListView.builder(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 itemCount: cartItems.length,
//                 itemBuilder: (context, index) {
//                   final item = cartItems[index];
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 12),
//                     child: _cartItemCard(item, index),
//                   );
//                 },
//               ),
//             ),

//             // Bottom fixed section
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Promo code
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           height: 50,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[100],
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           child: TextField(
//                             onChanged: (value) => promoCode = value.trim(),
//                             decoration: const InputDecoration(
//                               border: InputBorder.none,
//                               hintText: "Enter promo code",
//                               hintStyle: TextStyle(fontFamily: 'Poppins'),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             promoApplied = promoCode.toLowerCase() == 'oldmonk';
//                           });
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF2F9050),
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 24, vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                         ),
//                         child: const Text(
//                           "Apply",
//                           style: TextStyle(
//                               color: Colors.white, fontFamily: 'Poppins'),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),

//                   // Summary
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.green.shade50,
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     child: Column(
//                       children: [
//                         _priceRow('Cart Total', cartTotal),
//                         _priceRow('Tax (18%)', tax),
//                         _priceRow('Promo Discount', -discount),
//                         const Divider(),
//                         _priceRow('Total', total, isBold: true),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 12),

//                   // Payment button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF2F9050),
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                       ),
//                       onPressed: _startStripePayment,
//                       child: const Text(
//                         'Proceed to payment',
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontFamily: 'Poppins',
//                             color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _cartItemCard(Map<String, dynamic> item, int index) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
//       ),
//       child: Row(
//         children: [
//           // Quantity Control
//           Container(
//             height: 80,
//             width: 50,
//             decoration: BoxDecoration(
//               color: const Color(0xFF2F9050),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                     onTap: () => _increaseQuantity(index),
//                     child: const Icon(Icons.add, color: Colors.white)),
//                 Text('${item['quantity']}',
//                     style: const TextStyle(
//                         color: Colors.white, fontFamily: 'Poppins')),
//                 GestureDetector(
//                     onTap: () => _decreaseQuantity(index),
//                     child: const Icon(Icons.remove, color: Colors.white)),
//               ],
//             ),
//           ),
//           const SizedBox(width: 10),

//           // Product Image
//           Container(
//             height: 80,
//             width: 80,
//             decoration: BoxDecoration(
//               color: const Color(0xFF2F9050),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: Center(
//                 child: Image.asset(
//                   _getImagePath(item['name']),
//                   width: 60,
//                   height: 60,
//                   errorBuilder: (context, error, stackTrace) => const Icon(
//                       Icons.image_not_supported,
//                       color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),

//           // Product Info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(item['name'],
//                     style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: 'Poppins')),
//                 const SizedBox(height: 4),
//                 Text('₹${item['price'].toStringAsFixed(2)}',
//                     style: const TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF2F9050),
//                         fontFamily: 'Poppins')),
//               ],
//             ),
//           ),

//           // Delete Button
//           GestureDetector(
//               onTap: () => _removeItem(index),
//               child: const Icon(Icons.close, color: Colors.red)),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'dart:convert';
import 'package:sparnet/frontend/bill.dart';

class CartScreen extends StatefulWidget {
  final String phoneNumber;
  const CartScreen({super.key, required this.phoneNumber});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [];
  String promoCode = "";
  bool promoApplied = false;

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    final url =
        Uri.parse('http://192.168.213.31:5000/cart/${widget.phoneNumber}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> items = data['cart'];
        setState(() {
          cartItems = items
              .map((item) => {
                    'id': item['_id'],
                    'name': item['name'],
                    'price': item['price'],
                    'imagePath': item['imagePath'] ?? 'assets/placeholder.png',
                    'quantity': 1,
                  })
              .toList();
        });
      } else {
        print("Failed to load cart items: ${response.body}");
      }
    } catch (e) {
      print("Error fetching cart items: $e");
    }
  }

  void _increaseQuantity(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      }
    });
  }

  void _removeItem(int index) async {
    String id = cartItems[index]['id'];
    final url = Uri.parse('http://192.168.213.31:5000/cart/delete/$id');
    await http.delete(url);
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void _clearCart() async {
    for (var item in cartItems) {
      final url =
          Uri.parse('http://192.168.213.31:5000/cart/delete/${item['id']}');
      await http.delete(url);
    }
    setState(() {
      cartItems.clear();
    });
  }

  double _calculateTotal() {
    return cartItems.fold(
      0.0,
      (sum, item) => sum + item['price'] * item['quantity'],
    );
  }

  Widget _priceRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontFamily: 'Poppins')),
          Text('₹${value.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: const Color(0xFF2F9050),
                  fontFamily: 'Poppins')),
        ],
      ),
    );
  }

  Future<void> _startStripePayment() async {
    try {
      final totalAmount = ((_calculateTotal() * 1.18) * 100).round();

      final response = await http.post(
        Uri.parse('http://192.168.213.31:5000/create-payment-intent'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'amount': totalAmount}),
      );

      final jsonResp = json.decode(response.body);
      final clientSecret = jsonResp['clientSecret'];

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Sparnet Store',
          style: ThemeMode.light,
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Payment successful!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BillReceiptPage(phoneNumber: widget.phoneNumber),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Payment failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartTotal = _calculateTotal();
    final tax = cartTotal * 0.18;
    final discount = promoApplied ? cartTotal * 0.2 : 0.0;
    final total = cartTotal + tax - discount;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFD7F0D9),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back, size: 28),
                  const Text(
                    'Your Cart',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'),
                  ),
                  ElevatedButton(
                    onPressed: _clearCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Empty Cart',
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Scrollable cart items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _cartItemCard(item, index),
                  );
                },
              ),
            ),

            // Bottom fixed section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Promo code
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextField(
                            onChanged: (value) => promoCode = value.trim(),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter promo code",
                              hintStyle: TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            promoApplied = promoCode.toLowerCase() == 'oldmonk';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F9050),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          "Apply",
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Poppins'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Summary
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        _priceRow('Cart Total', cartTotal),
                        _priceRow('Tax (18%)', tax),
                        _priceRow('Promo Discount', -discount),
                        const Divider(),
                        _priceRow('Total', total, isBold: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Payment button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2F9050),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: _startStripePayment,
                      child: const Text(
                        'Proceed to payment',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartItemCard(Map<String, dynamic> item, int index) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        children: [
          // Quantity Control
          Container(
            height: 80,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF2F9050),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () => _increaseQuantity(index),
                    child: const Icon(Icons.add, color: Colors.white)),
                Text('${item['quantity']}',
                    style: const TextStyle(
                        color: Colors.white, fontFamily: 'Poppins')),
                GestureDetector(
                    onTap: () => _decreaseQuantity(index),
                    child: const Icon(Icons.remove, color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Product Image using imagePath from DB
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF2F9050),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Center(
                child: Image.asset(
                  item['imagePath'],
                  width: 60,
                  height: 60,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.image_not_supported,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name'],
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins')),
                const SizedBox(height: 4),
                Text('₹${item['price'].toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2F9050),
                        fontFamily: 'Poppins')),
              ],
            ),
          ),

          // Delete Button
          GestureDetector(
              onTap: () => _removeItem(index),
              child: const Icon(Icons.close, color: Colors.red)),
        ],
      ),
    );
  }
}
