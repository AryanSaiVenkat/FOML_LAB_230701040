// import 'package:flutter/material.dart';
// import 'package:sparnet/frontend/homepage.dart';
// import 'package:sparnet/frontend/signinpage.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _numberController = TextEditingController();
//   final TextEditingController _pinController = TextEditingController();
//   bool _obscurePin = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFCEEAD7),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Top Illustration
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Image.asset('assets/login.png'),
//               ),
//               const SizedBox(height: 40),
//               // Form Section
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Number Field
//                       const Text(
//                         "Number",
//                         style: TextStyle(
//                           fontFamily: 'Poppins',
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       TextFormField(
//                         controller: _numberController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           hintText: "Enter Number",
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 15, vertical: 10),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please enter your number";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 25),
//                       // Pin Field
//                       const Text(
//                         "Sparnet pin",
//                         style: TextStyle(
//                           fontFamily: 'Poppins',
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       TextFormField(
//                         controller: _pinController,
//                         obscureText: _obscurePin,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           hintText: "Enter Pin",
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 15, vertical: 10),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _obscurePin
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                               color: Colors.black54,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _obscurePin = !_obscurePin;
//                               });
//                             },
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please enter your pin";
//                           }
//                           if (value.length < 4) {
//                             return "Pin must be at least 4 digits";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 30),
//                       // Log In Button
//                       Center(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const HomeScreen()),
//                               );
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF239664),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 50, vertical: 12),
//                             elevation: 5,
//                           ),
//                           child: const Text(
//                             "Log in",
//                             style: TextStyle(
//                               fontFamily: 'Poppins',
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       // Sign In Navigation
//                       Center(
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const SignInScreen()),
//                             );
//                           },
//                           child: const Text.rich(
//                             TextSpan(
//                               text: "Don't have an account? ",
//                               style: TextStyle(
//                                 fontFamily: 'Poppins',
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black,
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: "Sign in",
//                                   style: TextStyle(
//                                     fontFamily: 'Poppins',
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0xFF239664),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sparnet/frontend/homepage.dart';
import 'package:sparnet/frontend/signinpage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  bool _obscurePin = true;
  bool _isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final String phone = _numberController.text.trim();
    final String pin = _pinController.text.trim();

    try {
      final response = await http.post(
        // Uri.parse(
        //     'http://192.168.137.1:5000/login'),
        // Uri.parse(
        //     'http://192.168.183.31:5000/login'), // Replace with your actual API URL
        Uri.parse('http://192.168.213.31:5000/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone, "pin": pin}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful!")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(phoneNumber: phone)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData["error"] ?? "Login failed")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Network error. Try again.")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _numberController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCEEAD7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Illustration
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('assets/login.png'),
              ),
              const SizedBox(height: 40),

              // Form Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Number Field
                      const Text(
                        "Number",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _numberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter Number",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your number";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),

                      // Pin Field
                      const Text(
                        "Sparnet pin",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _pinController,
                        obscureText: _obscurePin,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter Pin",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePin
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePin = !_obscurePin;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your pin";
                          }
                          if (value.length < 4) {
                            return "Pin must be at least 4 digits";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      // Log In Button
                      Center(
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF239664),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 12),
                            elevation: 5,
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  "Log in",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Sign In Navigation
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()),
                            );
                          },
                          child: const Text.rich(
                            TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Sign in",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF239664),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
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
