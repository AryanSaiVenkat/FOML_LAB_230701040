// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:flutter/rendering.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: BillReceiptPage(),
//   ));
// }

// class BillReceiptPage extends StatefulWidget {
//   const BillReceiptPage({super.key});

//   @override
//   State<BillReceiptPage> createState() => _BillReceiptPageState();
// }

// class _BillReceiptPageState extends State<BillReceiptPage> {
//   final GlobalKey _repaintKey = GlobalKey();

//   Future<void> _captureAndDownloadPDF() async {
//     final boundary =
//         _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//     final image = await boundary.toImage(pixelRatio: 3.0);
//     final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     final pngBytes = byteData!.buffer.asUint8List();

//     final pdf = pw.Document();
//     final imageProvider = pw.MemoryImage(pngBytes);

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) =>
//             pw.Center(child: pw.Image(imageProvider)),
//       ),
//     );

//     await Printing.layoutPdf(
//       onLayout: (PdfPageFormat format) async => pdf.save(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFCEEAD7),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Top section with taller dark background
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.only(top: 40, bottom: 16),
//               color: const Color(0xFF2F9050),
//               child: const Column(
//                 children: [
//                   Text(
//                     "SPARNET GROCERY",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     "123 Main Street, City, India",
//                     style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white70,
//                         fontFamily: 'Poppins'),
//                   ),
//                   Text(
//                     "support@sparnet.in | +91 9445387675",
//                     style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.white60,
//                         fontFamily: 'Poppins'),
//                   ),
//                 ],
//               ),
//             ),

//             // Bill content
//             Expanded(
//               child: SingleChildScrollView(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                 child: RepaintBoundary(
//                   key: _repaintKey,
//                   child: _buildBillContent(),
//                 ),
//               ),
//             ),

//             // Download button
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF2F9050),
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                   ),
//                   icon: const Icon(Icons.download, color: Colors.white),
//                   label: const Text(
//                     "Download",
//                     style:
//                         TextStyle(color: Colors.white, fontFamily: 'Poppins'),
//                   ),
//                   onPressed: _captureAndDownloadPDF,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBillContent() {
//     return Container(
//       padding: const EdgeInsets.all(22),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(28),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           const Text(
//             "Your Bill",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Poppins',
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Row(
//             children: [
//               Expanded(
//                 child: Text("INVOICE #: INV-000187",
//                     style: TextStyle(fontSize: 13, fontFamily: 'Poppins')),
//               ),
//               Expanded(
//                 child: Text("DATE: 13-Apr-2025",
//                     textAlign: TextAlign.right,
//                     style: TextStyle(fontSize: 13, fontFamily: 'Poppins')),
//               ),
//             ],
//           ),
//           const SizedBox(height: 6),
//           const Row(
//             children: [
//               Expanded(
//                 child: Text("CUSTOMER: +91-XXxx",
//                     style: TextStyle(fontSize: 13, fontFamily: 'Poppins')),
//               ),
//               Expanded(
//                 child: Text("ORDER ID: ORD-SPR123456",
//                     textAlign: TextAlign.right,
//                     style: TextStyle(fontSize: 13, fontFamily: 'Poppins')),
//               ),
//             ],
//           ),
//           const Divider(height: 30, thickness: 0.8),
//           const Row(
//             children: [
//               SizedBox(
//                 width: 30,
//                 child: Text("Sno",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         fontFamily: 'Poppins')),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Text("Item",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         fontFamily: 'Poppins')),
//               ),
//               Expanded(
//                 child: Center(
//                   child: Text("Qty",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                           fontFamily: 'Poppins')),
//                 ),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Text("Total",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                           fontFamily: 'Poppins')),
//                 ),
//               ),
//             ],
//           ),
//           const Divider(height: 10, thickness: 0.5),
//           itemRow("1", "Rice", "3", "₹120.00"),
//           itemRow("2", "Sugar", "4", "₹180.00"),
//           itemRow("3", "Ginger", "2", "₹180.00"),
//           const Divider(height: 20, thickness: 1.2),
//           summaryRow("Subtotal", "₹480.00"),
//           summaryRow("GST (18%)", "₹86.40"),
//           summaryRow("Promo Discount", "-₹96.00"),
//           const Divider(),
//           summaryRow("Total", "₹470.40", bold: true),
//           const SizedBox(height: 16),
//           const Text(
//             "PAYMENT STATUS: ✅ PAID VIA STRIPE",
//             style: TextStyle(
//               color: Colors.green,
//               fontWeight: FontWeight.w600,
//               fontSize: 15,
//               fontFamily: 'Poppins',
//             ),
//           ),
//           const SizedBox(height: 25),
//           const Text(
//             "Thank you for shopping with us!",
//             style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Poppins',
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             "For any queries, contact support@sparnet.in",
//             style: TextStyle(
//               fontSize: 13,
//               fontFamily: 'Poppins',
//               color: Colors.black54,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget itemRow(String sno, String item, String qty, String total) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           SizedBox(
//               width: 30,
//               child: Text(sno, style: const TextStyle(fontFamily: 'Poppins'))),
//           Expanded(
//               flex: 3,
//               child: Text(item, style: const TextStyle(fontFamily: 'Poppins'))),
//           Expanded(
//               child: Center(
//                   child: Text(qty,
//                       style: const TextStyle(fontFamily: 'Poppins')))),
//           Expanded(
//             child: Align(
//               alignment: Alignment.centerRight,
//               child: Text(total, style: const TextStyle(fontFamily: 'Poppins')),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget summaryRow(String label, String value, {bool bold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 3),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label,
//               style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: bold ? FontWeight.bold : FontWeight.normal,
//                   fontFamily: 'Poppins')),
//           Text(value,
//               style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: bold ? FontWeight.bold : FontWeight.normal,
//                   fontFamily: 'Poppins')),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:pdf/pdf.dart';
// import 'package:flutter/rendering.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'dart:convert';
// import 'dart:math';

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: BillReceiptPage(phoneNumber: "9445387675"),
//   ));
// }

// class BillReceiptPage extends StatefulWidget {
//   final String phoneNumber;
//   const BillReceiptPage({super.key, required this.phoneNumber});

//   @override
//   State<BillReceiptPage> createState() => _BillReceiptPageState();
// }

// class _BillReceiptPageState extends State<BillReceiptPage> {
//   final GlobalKey _repaintKey = GlobalKey();
//   List<Map<String, dynamic>> cartItems = [];
//   bool isLoading = true;
//   late String orderId;

//   @override
//   void initState() {
//     super.initState();
//     _generateOrderId();
//     _fetchCartItems();
//   }

//   void _generateOrderId() {
//     final random = Random();
//     orderId = 'ORD-${random.nextInt(99999).toString().padLeft(5, '0')}';
//   }

//   Future<void> _fetchCartItems() async {
//     final url =
//         Uri.parse('http://192.168.1.34:5000/cart/${widget.phoneNumber}');
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final items = List<Map<String, dynamic>>.from(data['cart']);
//         setState(() {
//           cartItems = items
//               .map((item) =>
//                   {'name': item['name'], 'quantity': 1, 'price': item['price']})
//               .toList();
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print("Failed to fetch cart: $e");
//     }
//   }

//   double get subtotal =>
//       cartItems.fold(0.0, (sum, item) => sum + (item['price']));
//   double get gst => subtotal * 0.18;
//   double get discount => subtotal * 0.2;
//   double get total => subtotal + gst - discount;

//   Future<void> _captureAndDownloadPDF() async {
//     final boundary =
//         _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//     final image = await boundary.toImage(pixelRatio: 3.0);
//     final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     final pngBytes = byteData!.buffer.asUint8List();

//     final pdf = pw.Document();
//     final imageProvider = pw.MemoryImage(pngBytes);

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) =>
//             pw.Center(child: pw.Image(imageProvider)),
//       ),
//     );

//     await Printing.layoutPdf(
//       onLayout: (PdfPageFormat format) async => pdf.save(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final String today =
//         '${DateTime.now().day.toString().padLeft(2, '0')}-${_monthName(DateTime.now().month)}-${DateTime.now().year}';

//     return Scaffold(
//       backgroundColor: const Color(0xFFCEEAD7),
//       body: SafeArea(
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : Column(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.only(top: 40, bottom: 16),
//                     color: const Color(0xFF2F9050),
//                     child: const Column(
//                       children: [
//                         Text(
//                           "SPARNET GROCERY",
//                           style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontFamily: 'Poppins',
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           "123 Main Street, City, India",
//                           style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white70,
//                               fontFamily: 'Poppins'),
//                         ),
//                         Text(
//                           "support@sparnet.in | +91 9445387675",
//                           style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.white60,
//                               fontFamily: 'Poppins'),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 20),
//                       child: RepaintBoundary(
//                         key: _repaintKey,
//                         child: _buildBillContent(today),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF2F9050),
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                         ),
//                         icon: const Icon(Icons.download, color: Colors.white),
//                         label: const Text(
//                           "Download",
//                           style: TextStyle(
//                               color: Colors.white, fontFamily: 'Poppins'),
//                         ),
//                         onPressed: _captureAndDownloadPDF,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }

//   Widget _buildBillContent(String today) {
//     return Container(
//       padding: const EdgeInsets.all(22),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(28),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           const Text(
//             "Your Bill",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Poppins',
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Expanded(
//                 child: Text("INVOICE #: ${orderId.replaceAll('ORD-', 'INV-')}",
//                     style:
//                         const TextStyle(fontSize: 13, fontFamily: 'Poppins')),
//               ),
//               Expanded(
//                 child: Text("DATE: $today",
//                     textAlign: TextAlign.right,
//                     style:
//                         const TextStyle(fontSize: 13, fontFamily: 'Poppins')),
//               ),
//             ],
//           ),
//           const SizedBox(height: 6),
//           Row(
//             children: [
//               Expanded(
//                 child: Text("CUSTOMER: +91-${widget.phoneNumber}",
//                     style:
//                         const TextStyle(fontSize: 13, fontFamily: 'Poppins')),
//               ),
//               Expanded(
//                 child: Text("ORDER ID: $orderId",
//                     textAlign: TextAlign.right,
//                     style:
//                         const TextStyle(fontSize: 13, fontFamily: 'Poppins')),
//               ),
//             ],
//           ),
//           const Divider(height: 30, thickness: 0.8),
//           const Row(
//             children: [
//               SizedBox(
//                 width: 30,
//                 child: Text("Sno",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         fontFamily: 'Poppins')),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Text("Item",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         fontFamily: 'Poppins')),
//               ),
//               Expanded(
//                 child: Center(
//                   child: Text("Qty",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                           fontFamily: 'Poppins')),
//                 ),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Text("Total",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                           fontFamily: 'Poppins')),
//                 ),
//               ),
//             ],
//           ),
//           const Divider(height: 10, thickness: 0.5),
//           for (int i = 0; i < cartItems.length; i++)
//             itemRow(
//                 "${i + 1}",
//                 cartItems[i]['name'],
//                 cartItems[i]['quantity'].toString(),
//                 "₹${cartItems[i]['price'].toStringAsFixed(2)}"),
//           const Divider(height: 20, thickness: 1.2),
//           summaryRow("Subtotal", "₹${subtotal.toStringAsFixed(2)}"),
//           summaryRow("GST (18%)", "₹${gst.toStringAsFixed(2)}"),
//           summaryRow("Promo Discount", "-₹${discount.toStringAsFixed(2)}"),
//           const Divider(),
//           summaryRow("Total", "₹${total.toStringAsFixed(2)}", bold: true),
//           const SizedBox(height: 16),
//           const Text(
//             "PAYMENT STATUS: ✅ PAID VIA STRIPE",
//             style: TextStyle(
//               color: Colors.green,
//               fontWeight: FontWeight.w600,
//               fontSize: 15,
//               fontFamily: 'Poppins',
//             ),
//           ),
//           const SizedBox(height: 25),
//           const Text(
//             "Thank you for shopping with us!",
//             style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w500,
//               fontFamily: 'Poppins',
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             "For any queries, contact support@sparnet.in",
//             style: TextStyle(
//               fontSize: 13,
//               fontFamily: 'Poppins',
//               color: Colors.black54,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget itemRow(String sno, String item, String qty, String total) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           SizedBox(
//               width: 30,
//               child: Text(sno, style: const TextStyle(fontFamily: 'Poppins'))),
//           Expanded(
//               flex: 3,
//               child: Text(item, style: const TextStyle(fontFamily: 'Poppins'))),
//           Expanded(
//               child: Center(
//                   child: Text(qty,
//                       style: const TextStyle(fontFamily: 'Poppins')))),
//           Expanded(
//             child: Align(
//               alignment: Alignment.centerRight,
//               child: Text(total, style: const TextStyle(fontFamily: 'Poppins')),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget summaryRow(String label, String value, {bool bold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 3),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label,
//               style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: bold ? FontWeight.bold : FontWeight.normal,
//                   fontFamily: 'Poppins')),
//           Text(value,
//               style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: bold ? FontWeight.bold : FontWeight.normal,
//                   fontFamily: 'Poppins')),
//         ],
//       ),
//     );
//   }

//   String _monthName(int month) {
//     const months = [
//       '',
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec'
//     ];
//     return months[month];
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:convert';
import 'dart:math';

class BillReceiptPage extends StatefulWidget {
  final String phoneNumber;
  const BillReceiptPage({super.key, required this.phoneNumber});

  @override
  State<BillReceiptPage> createState() => _BillReceiptPageState();
}

class _BillReceiptPageState extends State<BillReceiptPage> {
  final GlobalKey _repaintKey = GlobalKey();
  List<Map<String, dynamic>> cartItems = [];
  bool isLoading = true;
  late String orderId;

  @override
  void initState() {
    super.initState();
    _generateOrderId();
    _fetchCartItems();
  }

  void _generateOrderId() {
    final random = Random();
    orderId = 'ORD-${random.nextInt(99999).toString().padLeft(5, '0')}';
  }

  Future<void> _fetchCartItems() async {
    final url =
        Uri.parse('http://192.168.213.31:5000/cart/${widget.phoneNumber}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final items = List<Map<String, dynamic>>.from(data['cart']);
        setState(() {
          cartItems = items
              .map((item) => {
                    'name': item['name'],
                    'quantity': 1,
                    'price': item['price'],
                  })
              .toList();
          isLoading = false;
        });
      }
    } catch (e) {
      print("Failed to fetch cart: $e");
    }
  }

  Future<void> _clearCartFromDB() async {
    final url =
        Uri.parse('http://192.168.213.31:5000/cart/${widget.phoneNumber}');
    try {
      await http.delete(url);
      print("🗑️ Cart cleared for ${widget.phoneNumber}");
    } catch (e) {
      print("Error clearing cart: $e");
    }
  }

  double get subtotal =>
      cartItems.fold(0.0, (sum, item) => sum + (item['price']));
  double get gst => subtotal * 0.18;
  double get discount => subtotal * 0.2;
  double get total => subtotal + gst - discount;

  Future<void> _captureAndDownloadPDF() async {
    try {
      final boundary = _repaintKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final pdf = pw.Document();
      final imageProvider = pw.MemoryImage(pngBytes);

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) =>
              pw.Center(child: pw.Image(imageProvider)),
        ),
      );

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );

      // ✅ Clear cart after download
      await _clearCartFromDB();

      // Optional confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("🧾 Bill downloaded & cart cleared")),
      );
    } catch (e) {
      print("Error during PDF download: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final String today =
        '${DateTime.now().day.toString().padLeft(2, '0')}-${_monthName(DateTime.now().month)}-${DateTime.now().year}';

    return Scaffold(
      backgroundColor: const Color(0xFFCEEAD7),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 40, bottom: 16),
                    color: const Color(0xFF2F9050),
                    child: const Column(
                      children: [
                        Text(
                          "SPARNET GROCERY",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "123 Main Street, City, India",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                              fontFamily: 'Poppins'),
                        ),
                        Text(
                          "support@sparnet.in | +91 9445387675",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white60,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: RepaintBoundary(
                        key: _repaintKey,
                        child: _buildBillContent(today),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F9050),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        icon: const Icon(Icons.download, color: Colors.white),
                        label: const Text(
                          "Download",
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Poppins'),
                        ),
                        onPressed: _captureAndDownloadPDF,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildBillContent(String today) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Your Bill",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text("INVOICE #: ${orderId.replaceAll('ORD-', 'INV-')}",
                    style:
                        const TextStyle(fontSize: 13, fontFamily: 'Poppins')),
              ),
              Expanded(
                child: Text("DATE: $today",
                    textAlign: TextAlign.right,
                    style:
                        const TextStyle(fontSize: 13, fontFamily: 'Poppins')),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Text("CUSTOMER: +91-${widget.phoneNumber}",
                    style:
                        const TextStyle(fontSize: 13, fontFamily: 'Poppins')),
              ),
              Expanded(
                child: Text("ORDER ID: $orderId",
                    textAlign: TextAlign.right,
                    style:
                        const TextStyle(fontSize: 13, fontFamily: 'Poppins')),
              ),
            ],
          ),
          const Divider(height: 30, thickness: 0.8),
          const Row(
            children: [
              SizedBox(
                width: 30,
                child: Text("Sno",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'Poppins')),
              ),
              Expanded(
                flex: 3,
                child: Text("Item",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'Poppins')),
              ),
              Expanded(
                child: Center(
                  child: Text("Qty",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: 'Poppins')),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("Total",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: 'Poppins')),
                ),
              ),
            ],
          ),
          const Divider(height: 10, thickness: 0.5),
          for (int i = 0; i < cartItems.length; i++)
            itemRow(
              "${i + 1}",
              cartItems[i]['name'],
              cartItems[i]['quantity'].toString(),
              "₹${cartItems[i]['price'].toStringAsFixed(2)}",
            ),
          const Divider(height: 20, thickness: 1.2),
          summaryRow("Subtotal", "₹${subtotal.toStringAsFixed(2)}"),
          summaryRow("GST (18%)", "₹${gst.toStringAsFixed(2)}"),
          summaryRow("Promo Discount", "-₹${discount.toStringAsFixed(2)}"),
          const Divider(),
          summaryRow("Total", "₹${total.toStringAsFixed(2)}", bold: true),
          const SizedBox(height: 16),
          const Text(
            "PAYMENT STATUS: ✅ PAID VIA STRIPE",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            "Thank you for shopping with us!",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "For any queries, contact support@sparnet.in",
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins',
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget itemRow(String sno, String item, String qty, String total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
              width: 30,
              child: Text(sno, style: const TextStyle(fontFamily: 'Poppins'))),
          Expanded(
              flex: 3,
              child: Text(item, style: const TextStyle(fontFamily: 'Poppins'))),
          Expanded(
              child: Center(
                  child: Text(qty,
                      style: const TextStyle(fontFamily: 'Poppins')))),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(total, style: const TextStyle(fontFamily: 'Poppins')),
            ),
          ),
        ],
      ),
    );
  }

  Widget summaryRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  fontFamily: 'Poppins')),
          Text(value,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  fontFamily: 'Poppins')),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month];
  }
}
