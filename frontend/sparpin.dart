// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
// import 'package:sparnet/frontend/homepage.dart';

// class PinSetupScreen extends StatefulWidget {
//   const PinSetupScreen({super.key});

//   @override
//   _PinSetupScreenState createState() => _PinSetupScreenState();
// }

// class _PinSetupScreenState extends State<PinSetupScreen> {
//   final TextEditingController _pinController = TextEditingController();
//   final TextEditingController _confirmPinController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isObscured = true; // Toggle for PIN visibility

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFCEEAD7),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Background Image
//             Positioned(
//               top: 40,
//               left: 30,
//               right: 30,
//               child: Image.asset('assets/sparpin.png'),
//             ),

//             // White Card with PIN Inputs
//             Positioned(
//               bottom: 150,
//               left: 20,
//               right: 20,
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Enter PIN",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Expanded(child: _buildPinput(_pinController)),
//                           const SizedBox(width: 10),
//                           _buildEyeIcon(),
//                         ],
//                       ),
//                       const SizedBox(height: 30),
//                       const Text(
//                         "Confirm PIN",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Expanded(child: _buildPinput(_confirmPinController)),
//                           const SizedBox(width: 10),
//                           _buildEyeIcon(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             // Confirm Button
//             Positioned(
//               bottom: 60,
//               left: 40,
//               right: 40,
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const HomeScreen()),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF239664),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   elevation: 5,
//                 ),
//                 child: const Text(
//                   "Confirm & Continue",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // PIN Input Field with Underline Style
//   Widget _buildPinput(TextEditingController controller) {
//     return Pinput(
//       controller: controller,
//       length: 4,
//       obscureText: _isObscured,
//       defaultPinTheme: const PinTheme(
//         height: 56,
//         width: 56,
//         textStyle: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         ),
//         decoration: BoxDecoration(
//           border: Border(
//             bottom: BorderSide(color: Colors.green, width: 2),
//           ),
//         ),
//       ),
//       validator: (value) {
//         if (controller == _confirmPinController &&
//             value != _pinController.text) {
//           return "PINs do not match";
//         }
//         if (value == null || value.length < 4) {
//           return "Enter a valid 4-digit PIN";
//         }
//         return null;
//       },
//     );
//   }

//   // Eye Icon to Toggle PIN Visibility
//   Widget _buildEyeIcon() {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _isObscured = !_isObscured;
//         });
//       },
//       child: Icon(
//         _isObscured ? Icons.visibility_off : Icons.visibility,
//         color: Colors.grey,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
// import 'package:sparnet/frontend/homepage.dart';

// class PinSetupScreen extends StatefulWidget {
//   final String name;
//   final String phone;
//   final String email;

//   const PinSetupScreen({
//     super.key,
//     required this.name,
//     required this.phone,
//     required this.email,
//   });

//   @override
//   _PinSetupScreenState createState() => _PinSetupScreenState();
// }

// class _PinSetupScreenState extends State<PinSetupScreen> {
//   final TextEditingController _pinController = TextEditingController();
//   final TextEditingController _confirmPinController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isObscured = true; // Toggle for PIN visibility

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFCEEAD7),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Background Image
//             Positioned(
//               top: 40,
//               left: 30,
//               right: 30,
//               child: Image.asset('assets/sparpin.png'),
//             ),

//             // White Card with PIN Inputs
//             Positioned(
//               bottom: 150,
//               left: 20,
//               right: 20,
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Enter PIN",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Expanded(child: _buildPinput(_pinController)),
//                           const SizedBox(width: 10),
//                           _buildEyeIcon(),
//                         ],
//                       ),
//                       const SizedBox(height: 30),
//                       const Text(
//                         "Confirm PIN",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Expanded(child: _buildPinput(_confirmPinController)),
//                           const SizedBox(width: 10),
//                           _buildEyeIcon(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             // Confirm Button
//             Positioned(
//               bottom: 60,
//               left: 40,
//               right: 40,
//               child: ElevatedButton(
//                 // onPressed: () {
//                 //   if (_formKey.currentState!.validate()) {
//                 //     Navigator.push(
//                 //       context,
//                 //       MaterialPageRoute(
//                 //         builder: (context) => HomeScreen(
//                 //           name: widget.name,
//                 //           phone: widget.phone,
//                 //           email: widget.email,
//                 //         ),
//                 //       ),
//                 //     );
//                 //   }
//                 // },
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const HomeScreen()),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF239664),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   elevation: 5,
//                 ),
//                 child: const Text(
//                   "Confirm & Continue",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // PIN Input Field with Underline Style
//   Widget _buildPinput(TextEditingController controller) {
//     return Pinput(
//       controller: controller,
//       length: 4,
//       obscureText: _isObscured,
//       defaultPinTheme: const PinTheme(
//         height: 56,
//         width: 56,
//         textStyle: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         ),
//         decoration: BoxDecoration(
//           border: Border(
//             bottom: BorderSide(color: Colors.green, width: 2),
//           ),
//         ),
//       ),
//       validator: (value) {
//         if (controller == _confirmPinController &&
//             value != _pinController.text) {
//           return "PINs do not match";
//         }
//         if (value == null || value.length < 4) {
//           return "Enter a valid 4-digit PIN";
//         }
//         return null;
//       },
//     );
//   }

//   // Eye Icon to Toggle PIN Visibility
//   Widget _buildEyeIcon() {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _isObscured = !_isObscured;
//         });
//       },
//       child: Icon(
//         _isObscured ? Icons.visibility_off : Icons.visibility,
//         color: Colors.grey,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sparnet/frontend/homepage.dart';

class PinSetupScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String email;

  const PinSetupScreen({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
  });

  @override
  _PinSetupScreenState createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscured = true; // Toggle for PIN visibility
  bool _isLoading = false; // Loading state for button

  Future<void> _saveUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // final url = Uri.parse(
    //     "http://192.168.137.1:5000/save_user");
    // final url = Uri.parse(
    //     "http://192.168.183.31:5000/save_user"); // Replace with your backend URL
    final url = Uri.parse("http://192.168.213.31:5000/save_user");

    final Map<String, dynamic> userData = {
      "name": widget.name,
      "phone": widget.phone,
      "email": widget.email,
      "pin": _pinController.text,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(userData),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 201) {
        // Navigate to HomeScreen on success
        MaterialPageRoute(
          builder: (context) => HomeScreen(phoneNumber: widget.phone),
        );
      } else {
        _showMessage(responseData["error"] ?? "Failed to save user");
      }
    } catch (error) {
      _showMessage("Network error! Please try again.");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCEEAD7),
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image
            Positioned(
              top: 40,
              left: 30,
              right: 30,
              child: Image.asset('assets/sparpin.png'),
            ),

            // White Card with PIN Inputs
            Positioned(
              bottom: 150,
              left: 20,
              right: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Enter PIN",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: _buildPinput(_pinController)),
                          const SizedBox(width: 10),
                          _buildEyeIcon(),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Confirm PIN",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: _buildPinput(_confirmPinController)),
                          const SizedBox(width: 10),
                          _buildEyeIcon(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Confirm Button
            Positioned(
              bottom: 60,
              left: 40,
              right: 40,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF239664),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 5,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Confirm & Continue",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // PIN Input Field with Underline Style
  Widget _buildPinput(TextEditingController controller) {
    return Pinput(
      controller: controller,
      length: 4,
      obscureText: _isObscured,
      defaultPinTheme: const PinTheme(
        height: 56,
        width: 56,
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.green, width: 2)),
        ),
      ),
      validator: (value) {
        if (controller == _confirmPinController &&
            value != _pinController.text) {
          return "PINs do not match";
        }
        if (value == null || value.length < 4) {
          return "Enter a valid 4-digit PIN";
        }
        return null;
      },
    );
  }

  // Eye Icon to Toggle PIN Visibility
  Widget _buildEyeIcon() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isObscured = !_isObscured;
        });
      },
      child: Icon(
        _isObscured ? Icons.visibility_off : Icons.visibility,
        color: Colors.grey,
      ),
    );
  }
}
