// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:sparnet/frontend/cart.dart';
// import 'package:sparnet/frontend/homepage.dart';

// class ScannerPage extends StatefulWidget {
//   final String phoneNumber;
//   const ScannerPage({super.key, required this.phoneNumber});

//   @override
//   State<ScannerPage> createState() => _ScannerPageState();
// }

// class _ScannerPageState extends State<ScannerPage> {
//   bool isCameraActive = false;
//   bool isTorchOn = false;
//   String scannedData = "";
//   Map<String, dynamic>? scannedProduct;

//   final List<Map<String, dynamic>> localProductData = [
//     {
//       "name": "Rice",
//       "description": "Staple grain, used in various dishes across India.",
//       "image": "assets/rice.png",
//       "price": "₹45",
//       "barcode": "5625568070361",
//       "expiry_date": "2025-11-21"
//     },
//   ];

//   late MobileScannerController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = MobileScannerController(
//       detectionSpeed: DetectionSpeed.normal,
//       facing: CameraFacing.back,
//     );
//     controller.torchState.addListener(_onTorchStateChanged);
//   }

//   void _onTorchStateChanged() {
//     setState(() {
//       isTorchOn = controller.torchState.value == TorchState.on;
//     });
//   }

//   void toggleTorch() async {
//     await controller.toggleTorch();
//   }

//   @override
//   void dispose() {
//     controller.torchState.removeListener(_onTorchStateChanged);
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFD6EED4),
//       body: SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(height: 25),
//             _scannerBox(),
//             const SizedBox(height: 35),
//             _scannedDetails(),
//             const SizedBox(height: 35),
//             _actionButtons(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _bottomNavBar(context),
//     );
//   }

//   Widget _scannerBox() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: const Color(0xFF2F9050),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             offset: const Offset(4, 4),
//             blurRadius: 6,
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           Container(
//             height: 290,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: const Color(0xFF5D7FE6),
//                 width: 3,
//               ),
//             ),
//             child: isCameraActive
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(18),
//                     child: MobileScanner(
//                       controller: controller,
//                       onDetect: (capture) async {
//                         final barcode = capture.barcodes.first;
//                         if (barcode.rawValue != null) {
//                           controller.stop();
//                           setState(() {
//                             isCameraActive = false;
//                             scannedData = barcode.rawValue!;
//                             scannedProduct = localProductData.firstWhere(
//                               (product) => product['barcode'] == scannedData,
//                               orElse: () => {},
//                             );
//                           });
//                         }
//                       },
//                     ),
//                   )
//                 : const SizedBox.expand(),
//           ),
//           if (!isCameraActive)
//             Positioned(
//               bottom: 12,
//               left: 12,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black.withOpacity(0.6),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     isCameraActive = true;
//                     controller.start();
//                   });
//                 },
//                 child: const Text(
//                   "Access Camera",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _scannedDetails() {
//     return Stack(
//       children: [
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 20),
//           padding: const EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 offset: const Offset(4, 4),
//                 blurRadius: 6,
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "What You Scanned",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                   fontFamily: 'Poppins',
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Container(
//                 padding: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF2F9050),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _infoText(scannedProduct?['name'] ?? 'Product name'),
//                         const SizedBox(height: 10),
//                         _infoText(scannedProduct?['price'] ?? 'Price'),
//                         const SizedBox(height: 10),
//                         _infoText(
//                             scannedProduct?['expiry_date'] ?? 'Expiry date'),
//                       ],
//                     ),
//                     Container(
//                       width: 80,
//                       height: 80,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: const Color(0xFF1D7240),
//                       ),
//                       child: scannedProduct != null &&
//                               scannedProduct!['image'] != null
//                           ? ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.asset(
//                                 scannedProduct!['image'],
//                                 fit: BoxFit.cover,
//                               ),
//                             )
//                           : null,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           top: 3,
//           right: 25,
//           child: FloatingActionButton(
//             onPressed: toggleTorch,
//             backgroundColor: Colors.white,
//             elevation: 5,
//             mini: true,
//             child: Icon(
//               isTorchOn ? Icons.flashlight_off : Icons.flashlight_on,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _infoText(String text) {
//     return Text(
//       text,
//       style: const TextStyle(
//         fontSize: 16,
//         color: Colors.white,
//         fontFamily: 'Poppins',
//       ),
//     );
//   }

//   Widget _actionButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _button("Add to", Icons.shopping_cart, width: 140),
//         _button("Get details", null, width: 140),
//       ],
//     );
//   }

//   Widget _button(String text, IconData? icon, {double width = 150}) {
//     return SizedBox(
//       width: width,
//       height: 50,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF2F9050),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         onPressed: () {},
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (icon != null) ...[
//               Icon(icon, color: Colors.white, size: 20),
//               const SizedBox(width: 8),
//             ],
//             Text(
//               text,
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//                 fontFamily: 'Poppins',
//               ),
//             ),
//           ],
//         ),
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
//             Icons.storefront,
//             HomeScreen(phoneNumber: widget.phoneNumber),
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
// }

// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:sparnet/frontend/cart.dart';
// import 'package:sparnet/frontend/homepage.dart';

// class ScannerPage extends StatefulWidget {
//   final String phoneNumber;
//   const ScannerPage({super.key, required this.phoneNumber});

//   @override
//   State<ScannerPage> createState() => _ScannerPageState();
// }

// class _ScannerPageState extends State<ScannerPage> {
//   bool isCameraActive = false;
//   bool isTorchOn = false;
//   String scannedData = "";
//   Map<String, dynamic>? scannedProduct;

//   final List<Map<String, dynamic>> localProductData = [
//     {
//       "name": "Rice",
//       "description": "Staple grain, used in various dishes across India.",
//       "image": "assets/rice.png",
//       "price": "₹45",
//       "barcode": "5625568070361",
//       "expiry_date": "2025-11-21"
//     },
//   ];

//   late MobileScannerController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = MobileScannerController(
//       detectionSpeed: DetectionSpeed.normal,
//       facing: CameraFacing.back,
//     );
//     controller.torchState.addListener(_onTorchStateChanged);
//   }

//   void _onTorchStateChanged() {
//     setState(() {
//       isTorchOn = controller.torchState.value == TorchState.on;
//     });
//   }

//   void toggleTorch() async {
//     await controller.toggleTorch();
//   }

//   Future<void> addToCart() async {
//     if (scannedProduct == null) return;

//     // final url = Uri.parse("http://192.168.183.31:5000/add_item");
//     final url = Uri.parse("http://172.16.11.227:5000/add_item");
//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "phone": widget.phoneNumber,
//         "name": scannedProduct!["name"],
//         "description": scannedProduct!["description"],
//         "price":
//             int.tryParse(scannedProduct!["price"].replaceAll("₹", "")) ?? 0,
//       }),
//     );

//     if (response.statusCode == 201) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Item added to cart successfully!")),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to add item to cart.")),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     controller.torchState.removeListener(_onTorchStateChanged);
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFD6EED4),
//       body: SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(height: 25),
//             _scannerBox(),
//             const SizedBox(height: 35),
//             _scannedDetails(),
//             const SizedBox(height: 35),
//             _actionButtons(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _bottomNavBar(context),
//     );
//   }

//   Widget _scannerBox() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: const Color(0xFF2F9050),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             offset: const Offset(4, 4),
//             blurRadius: 6,
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           Container(
//             height: 290,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: const Color(0xFF5D7FE6),
//                 width: 3,
//               ),
//             ),
//             child: isCameraActive
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(18),
//                     child: MobileScanner(
//                       controller: controller,
//                       onDetect: (capture) async {
//                         final barcode = capture.barcodes.first;
//                         if (barcode.rawValue != null) {
//                           controller.stop();
//                           setState(() {
//                             isCameraActive = false;
//                             scannedData = barcode.rawValue!;
//                             scannedProduct = localProductData.firstWhere(
//                               (product) => product['barcode'] == scannedData,
//                               orElse: () => {},
//                             );
//                           });
//                         }
//                       },
//                     ),
//                   )
//                 : const SizedBox.expand(),
//           ),
//           if (!isCameraActive)
//             Positioned(
//               bottom: 12,
//               left: 12,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black.withOpacity(0.6),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     isCameraActive = true;
//                     controller.start();
//                   });
//                 },
//                 child: const Text(
//                   "Access Camera",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _scannedDetails() {
//     return Stack(
//       children: [
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 20),
//           padding: const EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 offset: const Offset(4, 4),
//                 blurRadius: 6,
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "What You Scanned",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                   fontFamily: 'Poppins',
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Container(
//                 padding: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF2F9050),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _infoText(scannedProduct?['name'] ?? 'Product name'),
//                         const SizedBox(height: 10),
//                         _infoText(scannedProduct?['price'] ?? 'Price'),
//                         const SizedBox(height: 10),
//                         _infoText(
//                             scannedProduct?['expiry_date'] ?? 'Expiry date'),
//                       ],
//                     ),
//                     Container(
//                       width: 80,
//                       height: 80,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: const Color(0xFF1D7240),
//                       ),
//                       child: scannedProduct != null &&
//                               scannedProduct!['image'] != null
//                           ? ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.asset(
//                                 scannedProduct!['image'],
//                                 fit: BoxFit.cover,
//                               ),
//                             )
//                           : null,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           top: 3,
//           right: 25,
//           child: FloatingActionButton(
//             onPressed: toggleTorch,
//             backgroundColor: Colors.white,
//             elevation: 5,
//             mini: true,
//             child: Icon(
//               isTorchOn ? Icons.flashlight_off : Icons.flashlight_on,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _infoText(String text) {
//     return Text(
//       text,
//       style: const TextStyle(
//         fontSize: 16,
//         color: Colors.white,
//         fontFamily: 'Poppins',
//       ),
//     );
//   }

//   Widget _actionButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _button("Add to", Icons.shopping_cart,
//             width: 140, onPressed: addToCart),
//         _button("Get details", null, width: 140, onPressed: () {}),
//       ],
//     );
//   }

//   Widget _button(String text, IconData? icon,
//       {double width = 150, required VoidCallback onPressed}) {
//     return SizedBox(
//       width: width,
//       height: 50,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF2F9050),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         onPressed: onPressed,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (icon != null) ...[
//               Icon(icon, color: Colors.white, size: 20),
//               const SizedBox(width: 8),
//             ],
//             Text(
//               text,
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//                 fontFamily: 'Poppins',
//               ),
//             ),
//           ],
//         ),
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
//             Icons.storefront,
//             HomeScreen(phoneNumber: widget.phoneNumber),
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
// }

// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:sparnet/frontend/cart.dart';
// import 'package:sparnet/frontend/homepage.dart';

// class ScannerPage extends StatefulWidget {
//   final String phoneNumber;
//   const ScannerPage({super.key, required this.phoneNumber});

//   @override
//   State<ScannerPage> createState() => _ScannerPageState();
// }

// class _ScannerPageState extends State<ScannerPage> {
//   bool isCameraActive = false;
//   bool isTorchOn = false;
//   String scannedData = "";
//   Map<String, dynamic>? scannedProduct;

//   late MobileScannerController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = MobileScannerController(
//       detectionSpeed: DetectionSpeed.normal,
//       facing: CameraFacing.back,
//     );
//     controller.torchState.addListener(_onTorchStateChanged);
//   }

//   void _onTorchStateChanged() {
//     setState(() {
//       isTorchOn = controller.torchState.value == TorchState.on;
//     });
//   }

//   void toggleTorch() async {
//     await controller.toggleTorch();
//   }

//   Future<void> fetchProductDetails(String barcode) async {
//     final url =
//         Uri.parse('http://172.16.11.227:5004/get_product_by_barcode/$barcode');
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           scannedProduct = data;
//         });
//       } else {
//         setState(() {
//           scannedProduct = null;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Product not found in dataset.")),
//         );
//       }
//     } catch (e) {
//       print("Error fetching product: $e");
//     }
//   }

//   Future<void> addToCart() async {
//     if (scannedProduct == null) return;

//     final url = Uri.parse("http://172.16.11.227:5000/add_item");
//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "phone": widget.phoneNumber,
//         "name": scannedProduct!["Name"],
//         "description": scannedProduct!["Detail"],
//         "price": int.tryParse(
//                 scannedProduct!["Price"].toString().replaceAll("₹", "")) ??
//             0,
//         "imagePath": scannedProduct!["Image Path"] ?? "assets/placeholder.png",
//       }),
//     );

//     if (response.statusCode == 201) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Item added to cart successfully!")),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to add item to cart.")),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     controller.torchState.removeListener(_onTorchStateChanged);
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFD6EED4),
//       body: SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(height: 25),
//             _scannerBox(),
//             const SizedBox(height: 35),
//             _scannedDetails(),
//             const SizedBox(height: 35),
//             _actionButtons(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _bottomNavBar(context),
//     );
//   }

//   Widget _scannerBox() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: const Color(0xFF2F9050),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             offset: const Offset(4, 4),
//             blurRadius: 6,
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           Container(
//             height: 290,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: const Color(0xFF5D7FE6),
//                 width: 3,
//               ),
//             ),
//             child: isCameraActive
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(18),
//                     child: MobileScanner(
//                       controller: controller,
//                       onDetect: (capture) async {
//                         final barcode = capture.barcodes.first;
//                         if (barcode.rawValue != null) {
//                           controller.stop();
//                           setState(() {
//                             isCameraActive = false;
//                             scannedData = barcode.rawValue!;
//                           });
//                           await fetchProductDetails(scannedData);
//                         }
//                       },
//                     ),
//                   )
//                 : const SizedBox.expand(),
//           ),
//           if (!isCameraActive)
//             Positioned(
//               bottom: 12,
//               left: 12,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black.withOpacity(0.6),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     isCameraActive = true;
//                     controller.start();
//                   });
//                 },
//                 child: const Text(
//                   "Access Camera",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _scannedDetails() {
//     return Stack(
//       children: [
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 20),
//           padding: const EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 offset: const Offset(4, 4),
//                 blurRadius: 6,
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "What You Scanned",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                   fontFamily: 'Poppins',
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Container(
//                 padding: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF2F9050),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _infoText(scannedProduct?['Name'] ?? 'Product name'),
//                         const SizedBox(height: 10),
//                         _infoText("₹${scannedProduct?['Price'] ?? 'Price'}"),
//                         const SizedBox(height: 10),
//                         _infoText(scannedProduct?['Expiry Date'] ??
//                             'Expiry date not available'),
//                       ],
//                     ),
//                     Container(
//                       width: 80,
//                       height: 80,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: const Color(0xFF1D7240),
//                       ),
//                       child: scannedProduct != null &&
//                               scannedProduct!['Image Path'] != null
//                           ? ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.asset(
//                                 scannedProduct!['Image Path'],
//                                 fit: BoxFit.cover,
//                               ),
//                             )
//                           : const Icon(Icons.image, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           top: 3,
//           right: 25,
//           child: FloatingActionButton(
//             onPressed: toggleTorch,
//             backgroundColor: Colors.white,
//             elevation: 5,
//             mini: true,
//             child: Icon(
//               isTorchOn ? Icons.flashlight_off : Icons.flashlight_on,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _infoText(String text) {
//     return Text(
//       text,
//       style: const TextStyle(
//         fontSize: 16,
//         color: Colors.white,
//         fontFamily: 'Poppins',
//       ),
//     );
//   }

//   Widget _actionButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _button("Add to", Icons.shopping_cart,
//             width: 140, onPressed: addToCart),
//         _button("Get details", null, width: 140, onPressed: () {}),
//       ],
//     );
//   }

//   Widget _button(String text, IconData? icon,
//       {double width = 150, required VoidCallback onPressed}) {
//     return SizedBox(
//       width: width,
//       height: 50,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF2F9050),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         onPressed: onPressed,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (icon != null) ...[
//               Icon(icon, color: Colors.white, size: 20),
//               const SizedBox(width: 8),
//             ],
//             Text(
//               text,
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//                 fontFamily: 'Poppins',
//               ),
//             ),
//           ],
//         ),
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
//             Icons.storefront,
//             HomeScreen(phoneNumber: widget.phoneNumber),
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
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sparnet/frontend/cart.dart';
import 'package:sparnet/frontend/homepage.dart';

class ScannerPage extends StatefulWidget {
  final String phoneNumber;
  const ScannerPage({super.key, required this.phoneNumber});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  bool isCameraActive = false;
  bool isTorchOn = false;
  String scannedData = "";
  Map<String, dynamic>? scannedProduct;

  late MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
    );
    controller.torchState.addListener(_onTorchStateChanged);
  }

  void _onTorchStateChanged() {
    setState(() {
      isTorchOn = controller.torchState.value == TorchState.on;
    });
  }

  void toggleTorch() async {
    await controller.toggleTorch();
  }

  Future<void> fetchProductDetails(String barcode) async {
    final url =
        Uri.parse('http://192.168.213.31:5004/get_product_by_barcode/$barcode');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          scannedProduct = data;
        });
      } else {
        setState(() {
          scannedProduct = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product not found in dataset.")),
        );
      }
    } catch (e) {
      print("Error fetching product: $e");
    }
  }

  Future<void> addToCart() async {
    if (scannedProduct == null) return;

    final url = Uri.parse("http://192.168.213.31:5000/add_item");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone": widget.phoneNumber,
        "name": scannedProduct!["Name"],
        "description": scannedProduct!["Detail"],
        "price": int.tryParse(
                scannedProduct!["Price"].toString().replaceAll("₹", "")) ??
            0,
        "imagePath": scannedProduct!["Image Path"] ?? "assets/placeholder.png",
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Item added to cart successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to add item to cart.")),
      );
    }
  }

  @override
  void dispose() {
    controller.torchState.removeListener(_onTorchStateChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6EED4),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),
            _scannerBox(),
            const SizedBox(height: 30),
            if (scannedProduct != null) _scannedDetails(),
            const SizedBox(height: 25),
            _actionButtons(),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavBar(context),
    );
  }

  Widget _scannerBox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF2F9050),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(4, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            height: 290,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF5D7FE6), width: 3),
            ),
            child: isCameraActive
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: MobileScanner(
                      controller: controller,
                      onDetect: (capture) async {
                        final barcode = capture.barcodes.first;
                        if (barcode.rawValue != null) {
                          controller.stop();
                          setState(() {
                            isCameraActive = false;
                            scannedData = barcode.rawValue!;
                          });
                          await fetchProductDetails(scannedData);
                        }
                      },
                    ),
                  )
                : const SizedBox.expand(),
          ),
          if (!isCameraActive)
            Positioned(
              bottom: 12,
              left: 12,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isCameraActive = true;
                    controller.start();
                  });
                },
                child: const Text(
                  "Access Camera",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _scannedDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(4, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF1D7240),
              ),
              child: scannedProduct!['Image Path'] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        scannedProduct!['Image Path'],
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(Icons.image, color: Colors.white),
            ),

            // Info Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scannedProduct!['Name'] ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    scannedProduct!['Detail'] ?? 'No description available',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Price: ₹${scannedProduct!['Price']}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Expiry: ${scannedProduct!['Expiry Date'] ?? 'N/A'}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
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

  Widget _actionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _button("Add to", Icons.shopping_cart,
            width: 140, onPressed: addToCart),
        _button("Get details", null, width: 140, onPressed: () {}),
      ],
    );
  }

  Widget _button(String text, IconData? icon,
      {double width = 150, required VoidCallback onPressed}) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F9050),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
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
            Icons.storefront,
            HomeScreen(phoneNumber: widget.phoneNumber),
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
}
