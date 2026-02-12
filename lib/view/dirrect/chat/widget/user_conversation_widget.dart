import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slaac/view/dirrect/chat/widget/chat_bubble.dart';

/// Widget to display the user's conversation
class UserConversationWidget extends StatelessWidget {
  /// Constructor
  const UserConversationWidget({
    required this.scrollController,
    required this.messages,
    required this.senderId,
    required this.receiverId,
    this.lastReadByReceiverAt,
    super.key,
  });

  /// Scroll controller
  final ScrollController scrollController;

  /// Messages
  final List<QueryDocumentSnapshot<Object?>> messages;

  /// Sender ID (current user)
  final String senderId;

  /// Receiver ID (other user) — used to read lastRead_{receiverId} for read receipts /
  final String receiverId;

  /// When the receiver last read the chat (for showing dark checkmarks)
  final DateTime? lastReadByReceiverAt;

  static DateTime? _messageTime(Map<String, dynamic> data) {
    final ts = data['timestamp'];
    if (ts == null) return null;
    if (ts is Timestamp) return ts.toDate();
    if (ts is String) return DateTime.tryParse(ts);

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: messages.length,
      itemBuilder: (_, index) {
        final doc = messages[index];
        final Map<String, dynamic> data =
            doc.data() as Map<String, dynamic>? ?? {};
        final bool isCurUser = data['senderId'] == senderId;
        final msgTime = _messageTime(data);
        final lastRead = lastReadByReceiverAt;
        final isRead = isCurUser &&
            lastRead != null &&
            msgTime != null &&
            !msgTime.isAfter(lastRead);

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Align(
            alignment: isCurUser ? Alignment.centerRight : Alignment.centerLeft,
            child: ChatBubble(
              message: data['message'] as String? ?? '',
              isCurrentUser: isCurUser,
              isRead: isRead,
              userId: data['senderId'] as String? ?? '',
              messageId: doc.id,
            ),
          ),
        );
      },
    );
  }
}
