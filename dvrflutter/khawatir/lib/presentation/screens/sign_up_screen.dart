// ignore_for_file: prefer_const_constructors, camel_case_types, unused_field, prefer_final_fields, unused_local_variable, unused_element, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khawatir/data/services/firebase_auth_service.dart';

class SiginUpnscrine extends StatefulWidget {
  const SiginUpnscrine({super.key});

  @override
  State<SiginUpnscrine> createState() => _SiginUpnscrineState();
}

class _SiginUpnscrineState extends State<SiginUpnscrine> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernamController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernamController.dispose();
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
                  'SIGN UP',
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                //Subtitle
                SizedBox(height: 20),
                //UsernamField
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _usernamController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Usernam',
                        ),
                      ),
                    ),
                  ),
                ),
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
                //sign_up_button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: _sigiUp,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(80)),
                      child: Center(
                        child: Text(
                          'Sign Up',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sigiUp() async {
    String usernam = _usernamController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUp(email, password);
    if (user != null) {
      print('User is succsessfully created');
      // Clear text fields
      _usernamController.text = "";
      _emailController.text = "";
      _passwordController.text = "";
      Navigator.pushNamed(context, 'HomeScreen');
    } else {
      print('Some error happend');
    }
  }
}
