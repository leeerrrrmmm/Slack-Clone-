import 'package:flutter/material.dart';

/// SentMessageWidget displays the input field and send button for messages.
class SentMessageWidget extends StatelessWidget {
  /// The text editing controller.
  final TextEditingController messageController;

  /// The focus node for the text field.
  final FocusNode focusNode;

  /// The callback function to send a message.
  final VoidCallback onSendMessage;

  /// Constructs a new SentMessageWidget.
  const SentMessageWidget({
    required this.messageController,
    required this.focusNode,
    required this.onSendMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    focusNode: focusNode,
                    controller: messageController,
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Out',
                    ),
                    decoration: InputDecoration(
                      hintText:
                          'Message #${DateTime.now().toString().substring(0, 10)}',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontFamily: 'Out',
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) {
                      if (messageController.text.trim().isNotEmpty) {
                        return;
                      } else {
                        onSendMessage();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: Color(0xFF441045),
                  shape: BoxShape.circle,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onSendMessage,
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
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
