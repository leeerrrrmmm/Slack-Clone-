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
    super.key,
  });

  /// Scroll controller
  final ScrollController scrollController;

  /// Messages
  final List<QueryDocumentSnapshot<Object?>> messages;

  /// Sender ID
  final String senderId;

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

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Align(
            alignment: isCurUser ? Alignment.centerRight : Alignment.centerLeft,
            child: ChatBubble(
              message: data['message'] as String? ?? '',
              isCurrentUser: isCurUser,
              userId: data['senderId'] as String? ?? '',
              messageId: doc.id,
            ),
          ),
        );
      },
    );
  }
}
