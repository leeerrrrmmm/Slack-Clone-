import 'package:firebase_auth/firebase_auth.dart';

/// SignInService is the service for user authentication.
class SignInService {
  /// The FirebaseAuth instance.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Minimum password length required by Firebase Auth.
  static const int _minPasswordLength = 6;

  /// Signs in a user with email and password.
  Future<void> signIn({
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

      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
        case 'wrong-password':
          errorMessage = 'Wrong password provided.';
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
        case 'user-disabled':
          errorMessage = 'This user account has been disabled.';
        case 'too-many-requests':
          errorMessage =
              'Too many requests. Please try again later.';
        case 'operation-not-allowed':
          errorMessage = 'Email/password sign-in is not enabled.';
        default:
          errorMessage = 'Authentication failed: ${e.message}';
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }
}
