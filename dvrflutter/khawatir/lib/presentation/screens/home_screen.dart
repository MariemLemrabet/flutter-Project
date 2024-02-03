// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khawatir/data/services/firebase_post_service.dart';
import 'package:khawatir/presentation/screens/EditPost.dart';
import 'package:khawatir/presentation/screens/PostScreen.dart';

class HomeScreen extends StatelessWidget {
  final FirebasePostService _postService = FirebasePostService();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Masquer le bouton de retour
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, 'loginscrine');
              },
              icon: const Icon(Icons.exit_to_app, color: Colors.amber))
        ],
        title: Text('Home Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CreatePostScreen();
              });
        },
        child: Icon(Icons.post_add_sharp),
        backgroundColor: Colors.amber,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _postService.getAllPosts(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                Map<String, dynamic>? data =
                    document.data() as Map<String, dynamic>?;

                if (data == null ||
                    !data.containsKey('email') ||
                    !data.containsKey('text')) {
                  // Le document ne contient pas les champs attendus, gérer cette situation
                  return ListTile(
                    title: Text('Invalid document'),
                    subtitle: Text(
                        'This document does not contain email and text fields.'),
                  );
                }
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                  child: GestureDetector(
                    onDoubleTap: () {
                      final String? usemail =
                          FirebaseAuth.instance.currentUser!.email;
                      if (usemail == data['email']) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return  EditPostScreen(
                                bodyText: data['text'],
                                docId: document.id,
                              );
                            });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: ListTile(
                        title: Text(
                          data['email'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        subtitle: Text(
                          data['text'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
