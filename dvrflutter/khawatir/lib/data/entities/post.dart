import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String email;
  final String text;
  final Timestamp timestamp;
  final String documentId; 
  Post({
    required this.email,
    required this.text,
    required this.timestamp,
    required this.documentId,
  });
   factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      email: map['email'] ?? '',
      text: map['text'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp(0, 0), 
      documentId: map['documentId'] ?? '', // Ajoute cette ligne pour récupérer documentId depuis la carte

    );
  }
}//La méthode fromMap est utile pour convertir 
//les données brutes provenant de Firestore en instances utilisables de la classe Post
