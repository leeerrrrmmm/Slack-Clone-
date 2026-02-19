import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/data/services/user_services/fetch_user_service.dart';
import 'package:slaac/view/home/widgets/unread_dm_chat_item.dart';

/// UnreadDMRow is the widget that displays the unread DM row.
class UnreadDMRow extends StatelessWidget {
  /// Constructs a new UnreadDMRow.
  const UnreadDMRow({
    required this.currentUser,
    required this.chatDoc,
    required this.fetchUserService,
    super.key,
  });

  /// Current user (for navigation to chat).
  final UserModel? currentUser;

  /// Chat document.
  final QueryDocumentSnapshot<Object?> chatDoc;

  /// Fetch user service.
  final FetchUserService fetchUserService;

  @override
  Widget build(BuildContext context) {
    final data = chatDoc.data() as Map<String, dynamic>? ?? {};
    final otherUserId = data['otherUserId'] as String? ?? '';
    final unreadCount = (data['unreadCount'] as num?)?.toInt() ?? 0;

    return FutureBuilder<UserModel?>(
      future: fetchUserService.fetchUserByUid(otherUserId),
      builder: (_, userSnapshot) {
        final otherUser = userSnapshot.data;
        final otherName = otherUser?.name ?? '';
        final otherEmail = otherUser?.email ?? '';

        return UnreadDMChatItem(
          currentUser: currentUser,
          otherName: otherName,
          otherUserId: otherUserId,
          otherEmail: otherEmail,
          unreadCount: unreadCount,
        );
      },
    );
  }
}
