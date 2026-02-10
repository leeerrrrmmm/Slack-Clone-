import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/view/dirrect/chat/chat_screen.dart';

/// UserTileWIdget is the widget that displays a user tile.
class UserTileWIdget extends StatelessWidget {
  /// Constructs a new UserTileWIdget.
  const UserTileWIdget({
    required this.currentUser,
    required this.otherName,
    required this.lastMessage,
    required this.timeStr,
    required this.otherUserId,
    required this.otherEmail,
    super.key,
  });

  /// Current user (for navigation to chat and displaying "you" name).
  final UserModel? currentUser;

  /// Other user name.
  final String otherName;

  /// Last message.
  final String lastMessage;

  /// Time string.
  final String timeStr;

  /// Other user ID.
  final String otherUserId;

  /// Other user email.
  final String otherEmail;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.person, color: Colors.black),
      ),
      title: Row(
        children: [
          if (currentUser != null) ...[
            Text(
              currentUser?.name ?? '',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Out',
              ),
            ),
          ],
          Expanded(
            child: Text(
              otherName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Out',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          lastMessage.isEmpty ? 'No messages yet' : lastMessage,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            fontFamily: 'Out',
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      trailing: timeStr.isNotEmpty
          ? Text(
              timeStr,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontFamily: 'Out',
              ),
            )
          : null,
      onTap: () {
        if (currentUser == null) return;
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => ChatScreen(
              senderId: currentUser?.uid ?? '',
              senderName: currentUser?.name ?? '',
              senderEmail: currentUser?.email ?? '',
              receiverId: otherUserId,
              receiverName: otherName,
              receiverEmail: otherEmail.isNotEmpty
                  ? otherEmail
                  : 'unknown@gmail.com',
            ),
          ),
        );
      },
    );
  }
}
