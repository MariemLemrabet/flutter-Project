// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khawatir/presentation/screens/home_screen.dart';
import 'package:khawatir/presentation/screens/login_screen.dart';

import 'package:khawatir/presentation/screens/sign_up_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Manually initialize Firebase
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyB__8M4cyjkIbLraBALwB6gVSNqv3vgXNk',
          appId: '1:139226985617:android:36b0eabdeefd431a107b30',
          messagingSenderId: '139226985617',
          projectId: 'khawatir-d3394'));
  runApp(khawatir());
}

class khawatir extends StatelessWidget {
  const khawatir({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 243, 226, 33)),
      routes: {
        'HomeScreen': (context) => HomeScreen(),
        'SiginUpnscrine': (context) => SiginUpnscrine(),
        'loginscrine': (context) => loginscrine(),

        // ... other routes ...
      },
      home: loginscrine(),
    );
  }
}
