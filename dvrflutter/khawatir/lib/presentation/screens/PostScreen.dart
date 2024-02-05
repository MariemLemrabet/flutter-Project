// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khawatir/data/services/firebase_post_service.dart';
import 'package:khawatir/presentation/screens/home_screen.dart';
import 'package:khawatir/presentation/widgets/PostForm.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController _postTextController = TextEditingController();
  bool _buttonClicked = false;
  void _updateButtonDecoration() {
    setState(() {
      _buttonClicked = _postTextController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color.fromARGB(255, 254, 254, 208),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50),
                Text(
                  'CREATE POST',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PostForm(
                  controller: _postTextController,
                  buttonClicked: _buttonClicked,
                  onSubmitPressed: _onSubmitButtonPressed,
                  updateButtonDecoration: _updateButtonDecoration,


                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSubmitButtonPressed() async {
    if (!_buttonClicked && _postTextController.text.isNotEmpty) {
      try {
        setState(() {
          _buttonClicked = true;
        });

        await _submitPost();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } catch (e) {
        print('Error submitting post: $e');
        _showErrorSnackBar('Error submitting post. Please try again.');
      } finally {
        setState(() {
          _buttonClicked = false;
        });
      }
    } else {
      _showErrorSnackBar('Please enter your post text.');
    }
  }

  Future<void> _submitPost() async {
    String postText = _postTextController.text;

    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      FirebasePostService _postService = FirebasePostService();

      await _postService.addPost(postText);

      _postTextController.text = "";
    } else {
      _showErrorSnackBar('User not authenticated.');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(message, textAlign: TextAlign.center),
        ),
        duration: Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

