import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePostService {
  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  Future<void> addPost(String postText, String email) async {
    try {
      await postsCollection.add({
        'text': postText,
        'timestamp': FieldValue.serverTimestamp(),
        'email': email,
        
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error adding post: $e');
      // Handle error as needed
    }
  }
}
