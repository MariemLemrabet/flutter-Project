// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebasePostService {
  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  Future addPost(String postText) async {
    final String? email = FirebaseAuth.instance.currentUser!.email;
    await postsCollection.add({
      'text': postText,
      'timestamp': DateTime.now(),
      'email': email,
    });
  }

  // Fonction pour récupérer tous les posts sous forme de flux
  Stream<QuerySnapshot> getAllPosts() {
    return postsCollection.orderBy('timestamp', descending: true).snapshots();
  }

  Future<void> editPost(String docId, String postText) async {
    await postsCollection.doc(docId).update({
      'text': postText,
    });
  }

  Future<void> deletePost(String docId) async {
    await postsCollection.doc(docId).delete();
  }
}
