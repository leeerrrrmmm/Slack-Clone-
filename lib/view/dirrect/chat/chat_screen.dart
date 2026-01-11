import 'package:flutter/material.dart';
import 'package:slaac/data/services/chat_service/chat_service.dart';
import 'package:slaac/view/dirrect/chat/widget/message_list_widget.dart';
import 'package:slaac/view/dirrect/chat/widget/sent_message_widget.dart';

/// ChatScreen is the screen that displays the chat between two users.
class ChatScreen extends StatefulWidget {
  /// The sender id.
  final String senderId;

  /// The sender name.
  final String senderName;

  /// The sender email.
  final String senderEmail;

  /// The receiver id.
  final String receiverId;

  /// The receiver name.
  final String receiverName;

  /// The receiver email.
  final String receiverEmail;

  /// Constructs a new ChatScreen.
  const ChatScreen({
    required this.senderId,
    required this.senderName,
    required this.senderEmail,
    required this.receiverId,
    required this.receiverName,
    required this.receiverEmail,
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();

  // TextField focus
  FocusNode myFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> sendMessage() async {
    if (_messageController.text.trim().isEmpty) {
      return;
    }

    try {
      await _chatService.sendMessage(
        widget.receiverId,
        _messageController.text.trim(),
      );
      _messageController.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending message: $e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        return;
      } else {
        Future.delayed(const Duration(milliseconds: 500), _scrollToBottom);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF441045),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  widget.receiverName.isNotEmpty
                      ? widget.receiverName[0].toUpperCase()
                      : 'U',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Out',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.receiverName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Out',
                    ),
                  ),
                  Text(
                    widget.receiverEmail,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                      fontFamily: 'Out',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              // TODO: Show user info dialog
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: MessageListWidget(
              chatService: _chatService,
              senderId: widget.senderId,
              receiverId: widget.receiverId,
              scrollController: _scrollController,
            ),
          ),
          SentMessageWidget(
            messageController: _messageController,
            focusNode: myFocusNode,
            onSendMessage: sendMessage,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
