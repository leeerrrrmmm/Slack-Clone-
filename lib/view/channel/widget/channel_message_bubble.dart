import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Single channel message bubble.
class ChannelMessageBubble extends StatelessWidget {
  /// Message text.
  final String text;

  /// Sender display name.
  final String senderName;

  /// Sender email.
  final String senderEmail;

  /// Whether this message is from current user.
  final bool isMe;

  /// Optional timestamp.
  final Timestamp? timestamp;

  /// Constructs a new ChannelMessageBubble.
  const ChannelMessageBubble({
    required this.text,
    required this.senderName,
    required this.senderEmail,
    required this.isMe,
    this.timestamp,
    super.key,
  });

  static String _formatTimestamp(Timestamp ts) {
    final date = ts.toDate();
    final hours = date.hour.toString().padLeft(2, '0');
    final minutes = date.minute.toString().padLeft(2, '0');

    return '$hours:$minutes';
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isMe
              ? const Color(0xFF441045)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isMe ? null : Border.all(color: const Color(0xFFECECEC)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe)
              Text(
                '$senderName ($senderEmail)',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF616061),
                  fontFamily: 'Out',
                ),
              ),
            Text(
              text,
              style: TextStyle(
                color: isMe ? Colors.white : const Color(0xFF1D1C1D),
                fontSize: 15,
                fontFamily: 'Out',
              ),
            ),
            const SizedBox(height: 4),
            if (timestamp case final Timestamp ts)
              Text(
                _formatTimestamp(ts),
                style: TextStyle(
                  fontSize: 11,
                  color: isMe
                      ? Colors.white.withValues(alpha: 0.8)
                      : const Color(0xFF616061),
                  fontFamily: 'Out',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
