import 'package:flutter/material.dart';

/// ReactionsInfoWidget is the widget that displays the reactions info.
class ReactionsInfoWidget extends StatelessWidget {
  /// Constructs a new ReactionsInfoWidget.
  const ReactionsInfoWidget({
    required this.emoji,
    required this.userName,
    required this.messageReaction,
    super.key,
  });

  /// Emoji(Emote)
  final String emoji;

  /// User Name
  final String userName;

  /// Message Reaction
  final String messageReaction;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Emoji(Emote)
        Text(
          emoji,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Out',
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Out',
              ),
            ),
            Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  messageReaction,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                    fontFamily: 'Out',
                  ),
                ),
                Container(
                  width: 45,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade400.withValues(alpha: 0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Text(emoji), const Text('1')],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
