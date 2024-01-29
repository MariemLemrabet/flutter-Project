// ignore_for_file: prefer_const_constructors, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khawatir/data/services/firebase_post_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController _postTextController = TextEditingController();

  @override
  void dispose() {
    _postTextController.dispose();
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
                // Title
                Text(
                  'CREATE POST',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                // Post Textfield
                Padding(
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
                         // Allow multiple lines
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 30),
                          border: InputBorder.none,
                          hintText: 'Write your post...',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                // Submit Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                      onTap: _submitPost,
                      child: Container(
                       width: 70, // Adjust the width as needed
                       height: 70, // Adjust the height as needed
                       decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                         ),
                        child: Center(
                           child: Icon(
                               Icons.send,
                                 color: Colors.white,
                                 size: 30,
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

 void _submitPost() async {
  String postText = _postTextController.text;

  if (postText.isNotEmpty) {
    // Assurez-vous que l'utilisateur est connecté
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Utilisez l'e-mail de l'utilisateur authentifié s'il est défini, sinon utilisez 'Unknown'
      String userEmail = currentUser.email ?? 'Unknown';

      // Instantiate the FirebasePostService
      FirebasePostService _postService = FirebasePostService();

      // Submit the post to Firebase collection
      await _postService.addPost(postText, userEmail);

      // Clear the text field
      _postTextController.text = "";

      // Optionally, navigate to a different screen after submission
      // Navigator.pushNamed(context, 'HomeScreen');
    } else {
      // L'utilisateur n'est pas connecté, gérer en conséquence
      _showErrorSnackBar('User not authenticated.');
    }
  } else {
    // Afficher un message d'erreur si le texte du post est vide
    _showErrorSnackBar('Please enter your post text.');
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
