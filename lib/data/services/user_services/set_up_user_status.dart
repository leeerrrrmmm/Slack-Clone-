import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slaac/data/model/selected_status.dart';

/// Set up user status service /
class SetUpUserStatusService {
  /// Set up user status /
  Future<void> setUpUserStatus(
    String userId,
    SelectedStatus selectedStatus,
  ) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.runTransaction(
      (transaction) async {
        final userDoc = await transaction.get(
          firestore.collection('users').doc(userId),
        );
        if (!userDoc.exists) {
          throw Exception('User not found');
        }
        transaction.set(userDoc.reference, {
          'status': setTitleEmoji(
            selectedStatus.title ?? '',
            selectedStatus.emoji ?? '',
          ),
        }, SetOptions(merge: true));
      },
    );
  }
}

/// Set title emoji /
String setTitleEmoji(String title, String emoji) {
  return '$emoji $title';
}
