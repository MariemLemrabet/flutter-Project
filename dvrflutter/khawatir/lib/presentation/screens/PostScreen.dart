// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khawatir/data/services/firebase_post_service.dart';
import 'package:khawatir/presentation/screens/home_screen.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController _postTextController = TextEditingController();
  bool _buttonClicked = false;

  @override
  void dispose() {
    _postTextController.dispose();
    super.dispose();
  }

  BoxDecoration _buttonDecoration() {
    return BoxDecoration(
      color: _buttonClicked || _postTextController.text.isEmpty
          ? Colors.grey
          : Colors.amber,
      shape: BoxShape.circle,
    );
  }

  void _onTextChanged() {
    setState(() {
      // Mettre à jour la décoration du bouton lorsque le texte change
    });
  }

  Future<void> _onSubmitButtonPressed() async {
  if (!_buttonClicked && _postTextController.text.isNotEmpty) {
    try {
      setState(() {
        _buttonClicked = true; // Mettez à jour _buttonClicked avant l'envoi
      });

      await _submitPost();

      // Naviguer vers la page HomeScreen après l'envoi du post
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      print('Error submitting post: $e');
      // Gérer l'erreur si l'envoi du post échoue
      _showErrorSnackBar('Error submitting post. Please try again.');
    } finally {
      setState(() {
        _buttonClicked = false; // Réactivez le bouton après l'envoi (succès ou échec)
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
                SizedBox(height: 30),
                _buildPostTextField(),
                SizedBox(height: 20),
                _buildSubmitButton(),
                 SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPostTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: _postTextController,
            maxLines: null,
            onChanged: (text) {
              _onTextChanged();
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 30),
              border: InputBorder.none,
              hintText: 'Write your post...',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: () {
          _onSubmitButtonPressed();
        },
        child: Container(
          width: 70,
          height: 70,
          decoration: _buttonDecoration(),
          child: Center(
            child: _buttonClicked
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Center(
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
          ),
        ),
      ),
    );
  
  }
}
