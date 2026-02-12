import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/view/dirrect/chat/chat_screen.dart';

/// Compact row: avatar + nickname (together), then purple oval with unread count.
class UnreadDMChatItem extends StatelessWidget {
  const UnreadDMChatItem({
    required this.currentUser,
    required this.otherName,
    required this.otherUserId,
    required this.otherEmail,
    required this.unreadCount,
    super.key,
  });

  final UserModel? currentUser;
  final String otherName;
  final String otherUserId;
  final String otherEmail;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          final user = currentUser;
          if (user == null) return;
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => ChatScreen(
                senderId: user.uid,
                senderName: user.name,
                senderEmail: user.email,
                receiverId: otherUserId,
                receiverName: otherName,
                receiverEmail: otherEmail.isNotEmpty
                    ? otherEmail
                    : 'unknown@gmail.com',
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.person, color: Colors.black),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    otherName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Out',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF441045),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  unreadCount > 99 ? '99+' : unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Out',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
