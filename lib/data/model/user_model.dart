import 'package:cloud_firestore/cloud_firestore.dart';

/// UserModel is the model for the user.
class UserModel {
  /// The id of the user.
  final String uid;

  /// The email of the user.
  final String email;

  /// The name of the user.
  final String name;

  /// The created at date of the user.
  final DateTime createdAt;

  /// Optional status string (e.g. "🌸 Tackling energizing spring tasks").
  final String? status;

  /// Constructs a new UserModel.
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.createdAt,
    this.status,
  });

  /// Converts a JSON object to a UserModel object.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      status: json['status'] as String?,
    );
  }

  /// Converts a UserModel object to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'createdAt': createdAt,
      if (status != null) 'status': status,
    };
  }
}
