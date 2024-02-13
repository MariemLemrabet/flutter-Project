import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khawatir/data/services/firebase_auth_service.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserCredential extends Mock implements UserCredential {}

void main() async {
  // Ensure Flutter bindings are initialized before running tests
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyB__8M4cyjkIbLraBALwB6gVSNqv3vgXNk',
        appId: '1:139226985617:android:36b0eabdeefd431a107b30',
        messagingSenderId: '139226985617',
        projectId: 'khawatir-d3394',
        storageBucket: 'khawatir-d3394.appspot.com',
      ),
    );
  });

  group('FirebaseAuthService', () {
    late FirebaseAuthService authService;
    late MockFirebaseAuth mockFirebaseAuth;

    setUp(() {
      // Create a new instance of FirebaseAuthService
      mockFirebaseAuth = MockFirebaseAuth();
      authService = FirebaseAuthService();
    });

    test('signUp - successful', () async {
      // Arrange
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'email', password: 'password'))
          .thenAnswer((_) async => MockUserCredential());

      // Act
      final result = await authService.signUp(
           'test@example.com',  'password123');

      // Assert
      expect(result, isA<User>());
    });

    test('signUp - error', () async {
      // Arrange
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'email', password: 'password'))
          .thenThrow(Exception('FirebaseError'));

      // Act
      final result = await authService.signUp(
           'test@example.com', 'password123');

      // Assert
      expect(result, isNull);
    });

    // Similarly, write tests for signIn method

    // test('signIn - successful', () async {
    // });

    // test('signIn - error', () async {
    // });

  });
}