// ignore_for_file: file_names, prefer_const_constructors, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';

class PostForm extends StatefulWidget {
  final TextEditingController controller;
  final bool buttonClicked;
   final VoidCallback onSubmitPressed;
   final VoidCallback updateButtonDecoration;

  const PostForm({
    Key? key,
    required this.controller,
    required this.buttonClicked,
    required this.onSubmitPressed,
    required this.updateButtonDecoration,
  }) : super(key: key);

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: widget.controller,
              maxLines: null,
              onChanged: (text) {
                 widget.updateButtonDecoration();// Mettre à jour la décoration du bouton lorsque le texte change
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 30),
                border: InputBorder.none,
                hintText: 'Write your post...',
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: widget.onSubmitPressed,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: widget.buttonClicked || widget.controller.text.isEmpty
                  ? Colors.grey
                  : Colors.amber,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: widget.buttonClicked
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
      ],
    );
  }
}
