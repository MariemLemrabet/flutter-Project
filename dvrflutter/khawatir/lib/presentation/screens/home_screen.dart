// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Column(children: [
        Text('Welcome to the Home Screen!'),
        GestureDetector(
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
        )
      ]),
    );
  }
}
