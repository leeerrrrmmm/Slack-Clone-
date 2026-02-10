import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slaac/data/services/chat_service/chat_service.dart';
import 'package:slaac/view/dirrect/chat/widget/error_chat_widget.dart';
import 'package:slaac/view/dirrect/chat/widget/no_message_yet_widget.dart';
import 'package:slaac/view/dirrect/chat/widget/user_conversation_widget.dart';

/// MessageListWidget displays the list of messages in the chat.
class MessageListWidget extends StatelessWidget {
  /// The chat service instance.
  final ChatService chatService;

  /// The sender user ID.
  final String senderId;

  /// The receiver user ID.
  final String receiverId;

  /// The scroll controller for auto-scrolling.
  final ScrollController scrollController;

  /// Constructs a new MessageListWidget.
  const MessageListWidget({
    required this.chatService,
    required this.senderId,
    required this.receiverId,
    required this.scrollController,

    super.key,
  });

  void _scrollToBottom(ScrollController controller) {
    if (!controller.hasClients) {
      return;
    }
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: StreamBuilder<QuerySnapshot>(
        stream: chatService.getMessages(senderId, receiverId),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return ErrorChatWidget(error: snapshot.error);
          }

          if (!snapshot.hasData || (snapshot.data?.docs.isEmpty ?? true)) {
            return const NoMessageYetWidget();
          }

          final messages = snapshot.data?.docs ?? [];

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom(scrollController);
          });

          return UserConversationWidget(
            scrollController: scrollController,
            messages: messages,
            senderId: senderId,
          );
        },
      ),
    );
  }
}
