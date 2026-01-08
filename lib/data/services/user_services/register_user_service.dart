import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// RegisterUserService is the service that registers a user in the database.
class RegisterUserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const int _minPasswordLength = 6;

  /// Регистрирует пользователя с автоинкрементным id
  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      // Валидация
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password cannot be empty');
      }

      if (password.length < _minPasswordLength) {
        throw Exception(
          'Password must be at least $_minPasswordLength characters',
        );
      }

      // Создаём пользователя через Firebase Auth
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = cred.user;
      if (user == null) throw Exception('User not created');

      // Ссылка на документ-счётчик пользователей
      final counterRef = _firestore.collection('counters').doc('users');

      await _firestore.runTransaction((transaction) async {
        final snap = await transaction.get(counterRef);

        // Берём последний ID, если документа нет — 0
        final int lastId = snap.data()?['last_id'] as int? ?? 0;
        final int newId = lastId + 1;

        // Обновляем счётчик
        transaction.set(counterRef, {
          'last_id': newId,
        }, SetOptions(merge: true));

        // Создаём документ пользователя с новым ID
        transaction.set(_firestore.collection('users').doc(user.uid), {
          'uid': user.uid,
          'id': newId,
          'email': email.trim(),
          'name': '',
          'createdAt': FieldValue.serverTimestamp(),
        });
      });
    } on FirebaseAuthException catch (e) {
      throw Exception('Firebase Auth Error: ${e.message}');
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
}
