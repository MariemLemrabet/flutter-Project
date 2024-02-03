// ignore_for_file: prefer_const_constructors, camel_case_types, unused_field, prefer_final_fields, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khawatir/data/services/firebase_auth_service.dart';
import 'package:khawatir/presentation/screens/sign_up_screen.dart';

class loginscrine extends StatefulWidget {
  const loginscrine({super.key});

  @override
  State<loginscrine> createState() => _loginscrineState();
}

class _loginscrineState extends State<loginscrine> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 254, 208),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50),
                //image
                Image.asset('images/icon.png'),

                //Titele
                SizedBox(height: 30),
                Text(
                  'SIGN IN',
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                //Subtitle
                SizedBox(height: 20),
               
                //Email Textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ),
                //passwor Textfield
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'password',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 25),
                //sign_in_button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: _login,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(80)),
                      child: Center(
                        child: Text(
                          'Log In',
                          style: GoogleFonts.robotoCondensed(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                //text:sign_up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not yet a member?',
                      style: GoogleFonts.robotoCondensed(
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                        onTap: _goToSignUp,
                        child: Text(
                          'Sign up now',
                          style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.bold, color: Colors.green),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goToSignUp() {
    // Navigate to the signup page
    Navigator.pushNamed(context, 'SiginUpnscrine');
  }

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    
    User? user = await _auth.signIn(email, password);
    if (user != null) {
      print('singin ');
      // Clear text fields
      
      _emailController.clear();
      _passwordController.clear();
      Navigator.pushNamed(context, 'HomeScreen');
    } else {
      // Show SnackBar with an error message
      _showErrorSnackBar('User does not exist or login failed');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(message, textAlign: TextAlign.center),
        ),
        duration: Duration(seconds: 5), // Adjust the duration as needed
      ),
    );
  }
}
