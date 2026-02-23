import 'package:flutter/material.dart';

/// Input bar for channel chat: text field and send button.
class ChannelInputBar extends StatelessWidget {
  /// Controller for the message text field.
  final TextEditingController messageController;

  /// Callback when send is pressed.
  final VoidCallback onSend;

  /// Constructs a new ChannelInputBar.
  const ChannelInputBar({
    required this.messageController,
    required this.onSend,
    super.key,
  });

  static const Color _accent = Color(0xFF441045);
  static const Color _border = Color(0xFFECECEC);
  static const Color _hint = Color(0xFF616061);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: _border, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: messageController,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF1D1C1D),
                  fontFamily: 'Out',
                ),
                decoration: InputDecoration(
                  hintText: 'Message #channel',
                  hintStyle: TextStyle(
                    color: _hint.withValues(alpha: 0.8),
                    fontFamily: 'Out',
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF8F8F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Material(
              color: _accent,
              borderRadius: BorderRadius.circular(22),
              child: InkWell(
                onTap: onSend,
                borderRadius: BorderRadius.circular(22),
                child: const SizedBox(
                  width: 44,
                  height: 44,
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
