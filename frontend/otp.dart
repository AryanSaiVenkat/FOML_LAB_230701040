// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
// import 'package:sparnet/frontend/sparpin.dart';

// class OtpVerificationScreen extends StatefulWidget {
//   const OtpVerificationScreen({super.key});

//   @override
//   _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
// }

// class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
//   final TextEditingController _otpController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFCEEAD7),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 10), // Moves image slightly lower
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 22),
//               child: Image.asset('assets/otp.png', height: 420),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Enter OTP",
//               style: TextStyle(
//                 fontFamily: 'Poppins',
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 15),
//             Form(
//               key: _formKey,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40),
//                 child: Pinput(
//                   controller: _otpController,
//                   length: 4,
//                   defaultPinTheme: PinTheme(
//                     height: 56,
//                     width: 56,
//                     textStyle: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16), // Rounded edges
//                       border: Border.all(color: Colors.transparent),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.length < 4) {
//                       return "Enter a valid 4-digit OTP";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   // Navigate to the next screen after OTP validation
// Navigator.push(
//   context,
//   MaterialPageRoute(
//       builder: (context) => const PinSetupScreen()),
// );
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF239664),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16), // Rounded edges
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
//                 elevation: 5,
//               ),
//               child: const Text(
//                 "Verify & Continue",
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
// import 'package:sparnet/frontend/sparpin.dart';

// class OtpVerificationScreen extends StatefulWidget {
//   final String name;
//   final String phone;
//   final String email;

//   const OtpVerificationScreen({
//     super.key,
//     required this.name,
//     required this.phone,
//     required this.email,
//   });

//   @override
//   _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
// }

// class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
//   final TextEditingController _otpController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFCEEAD7),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 10), // Moves image slightly lower
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 22),
//               child: Image.asset('assets/otp.png', height: 420),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Enter OTP",
//               style: TextStyle(
//                 fontFamily: 'Poppins',
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 15),
//             Form(
//               key: _formKey,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40),
//                 child: Pinput(
//                   controller: _otpController,
//                   length: 4,
//                   defaultPinTheme: PinTheme(
//                     height: 56,
//                     width: 56,
//                     textStyle: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16), // Rounded edges
//                       border: Border.all(color: Colors.transparent),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.length < 4) {
//                       return "Enter a valid 4-digit OTP";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   // Navigate to the next screen after OTP validation
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PinSetupScreen(
//                         name: widget.name,
//                         phone: widget.phone,
//                         email: widget.email,
//                       ),
//                     ),
//                   );
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF239664),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16), // Rounded edges
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
//                 elevation: 5,
//               ),
//               child: const Text(
//                 "Verify & Continue",
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sparnet/frontend/sparpin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpVerificationScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String email;

  const OtpVerificationScreen({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
  });

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _sendOtp(); // Send OTP automatically when the page loads
  }

  Future<void> _sendOtp() async {
    // final url = Uri.parse('http://192.168.183.31:5001/send_otp');
    final url = Uri.parse('http://192.168.213.31:5001/send_otp');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': widget.phone}),
    );
  }

  Future<void> _verifyOtp() async {
    setState(() {
      _isLoading = true;
    });
    //final url = Uri.parse('http://192.168.183.31:5001/verify_otp');
    final url = Uri.parse('http://192.168.213.31:5001/verify_otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': widget.phone, 'otp': _otpController.text}),
    );

    setState(() {
      _isLoading = false;
    });

    final data = jsonDecode(response.body);
    if (data['success']) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PinSetupScreen(
            name: widget.name,
            phone: widget.phone,
            email: widget.email,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wrong OTP! Try Again')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCEEAD7),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Image.asset('assets/otp.png', height: 420),
              ),
              const SizedBox(height: 20),
              const Text(
                "Enter OTP",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Pinput(
                    controller: _otpController,
                    length: 4,
                    defaultPinTheme: PinTheme(
                      height: 56,
                      width: 56,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.transparent),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 4) {
                        return "Enter a valid 4-digit OTP";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          _verifyOtp();
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF239664),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                  elevation: 5,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Verify & Continue",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
