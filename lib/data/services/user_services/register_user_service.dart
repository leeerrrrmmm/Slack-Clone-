import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// RegisterUserService is the service for the register user.
class RegisterUserService {
  /// The FirebaseFirestore instance.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// The FirebaseAuth instance.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Minimum password length required by Firebase Auth.
  static const int _minPasswordLength = 6;

  /// Registers a user.
  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      // Validate email and password
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password cannot be empty');
      }

      if (password.length < _minPasswordLength) {
        throw Exception(
          'Password must be at least $_minPasswordLength characters',
        );
      }

     

      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = cred.user;

      if (user == null) {
        throw Exception('User not created');
      }

      await _firestore.collection('users').doc(user.uid).set({
        'id': user.uid,
        'uid': user.uid,
        'email': email.trim(),
        'name': '',
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseAuthException catch (e) {
      throw Exception('Firebase Auth Error: ${e.message}');
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
}
