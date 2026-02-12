import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/data/services/user_services/fetch_user_service.dart';
import 'package:slaac/view/dirrect/widgets/user_tile_widget.dart';

const int _padLeftVal = 2;
String _formatTime(DateTime dateTime) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final msgDate = DateTime(
    dateTime.year,
    dateTime.month,
    dateTime.day,
  );
  final diff = today.difference(msgDate).inDays;
  if (diff == 0) {
    return '''${dateTime.hour.toString().padLeft(_padLeftVal, '0')}:${dateTime.minute.toString().padLeft(_padLeftVal, '0')}''';
  }
  if (diff == 1) return 'Yesterday';

  return '${dateTime.day}.${dateTime.month}';
}

/// ChatListItem is the widget that displays a chat list item.
class ChatListItem extends StatelessWidget {
  /// Constructs a new ChatListItem.
  const ChatListItem({
    required this.currentUser,
    required this.chatDoc,
    required this.fetchUserService,
    super.key,
  });

  /// Current user.
  final UserModel? currentUser;

  /// Chat document.
  final QueryDocumentSnapshot<Object?> chatDoc;

  /// Fetch user service.
  final FetchUserService fetchUserService;

  @override
  Widget build(BuildContext context) {
    final data = chatDoc.data() as Map<String, dynamic>? ?? {};
    final otherUserId = data['otherUserId'] as String? ?? '';
    final lastMessage = data['lastMessage'] as String? ?? '';
    final lastTimestamp = data['lastTimestamp'] as Timestamp?;

    return FutureBuilder<UserModel?>(
      future: fetchUserService.fetchUserByUid(otherUserId),
      builder: (_, userSnapshot) {
        final otherUser = userSnapshot.data;
        final otherName = otherUser?.name ?? '';
        final otherEmail = otherUser?.email ?? '';
        final timeStr = lastTimestamp != null
            ? _formatTime(lastTimestamp.toDate())
            : '';
        final isLoading =
            userSnapshot.connectionState == ConnectionState.waiting ||
            (!userSnapshot.hasData && !userSnapshot.hasError);

        return UserTileWIdget(
          currentUser: currentUser,
          otherName: otherName,
          lastMessage: lastMessage,
          timeStr: timeStr,
          otherUserId: otherUserId,
          otherEmail: otherEmail,
          isLoading: isLoading,
        );
      },
    );
  }
}
