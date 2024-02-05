// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, override_on_non_overriding_member

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khawatir/data/services/firebase_post_service.dart';
import 'package:khawatir/presentation/screens/home_screen.dart';
import 'package:khawatir/presentation/widgets/PostForm.dart';

class EditPostScreen extends StatefulWidget {
  final String bodyText;
  final String docId;

  const EditPostScreen({Key? key, required this.bodyText, required this.docId})
      : super(key: key);

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  TextEditingController _editTextController = TextEditingController();
  bool _buttonClicked = false;

  @override
  void initState() {
    super.initState();
    _editTextController.text = widget.bodyText;
  }

  void _updateButtonDecoration() {
    setState(() {
      _buttonClicked = _editTextController.text.isEmpty;
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
                  'EDIT POST',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PostForm(
                  controller: _editTextController,
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
    if (!_buttonClicked && _editTextController.text.isNotEmpty) {
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
    String postText = _editTextController.text;

    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      FirebasePostService _postService = FirebasePostService();

      await _postService.editPost(widget.docId, postText);

      _editTextController.text = "";
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
