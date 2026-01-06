import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:slaac/data/model/user_model.dart';

/// FetchUserService is the service for fetching a user.
class FetchUserService {
  /// The FirebaseFirestore instance.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetches a user by uid.
  Future<UserModel> fetchCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception('No authenticated user found');
    }

    final uid = currentUser.uid;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (!doc.exists) {
      throw Exception('User document not found in Firestore');
    }

    final data = doc.data();
    if (data == null) {
      throw Exception('User data is null');
    }

    return UserModel.fromJson(data);
  }

  /// Fetches all users from Firestore.
  Future<List<UserModel>> fetchAllUsers() async {
    final users = await _firestore.collection('users').get();

    return users.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }
}
