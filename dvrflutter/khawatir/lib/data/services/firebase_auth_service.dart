// data/services/firebase_auth_service.dart
// ignore_for_file: body_might_complete_normally_nullable, avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("som error occured");
    }
    return null;
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("som error occured");
    }
    return null;
  }

  createUserWithEmailAndPassword(
      {required String email, required String password}) {}
  // Méthode pour vérifier si un utilisateur est déjà connecté
  Future<User?> checkCurrentUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Utilisateur déjà connecté
        return user;
      } else {
        // Utilisateur déconnecté
        return null;
      }
    } catch (e) {
      print(
          "Une erreur s'est produite lors de la vérification de l'utilisateur actuel : $e");
      return null;
    }
  }
}
