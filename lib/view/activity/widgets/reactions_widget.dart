import 'package:flutter/material.dart';
import 'package:slaac/view/activity/widgets/reactions_info_widget.dart';

/// ReactionsWidget is the widget that displays the reactions of the app.
class ReactionsWidget extends StatelessWidget {
  /// Emoji(Emote)
  final String emoji;

  /// User Name
  final String userName;

  /// Message Reaction
  final String messageReaction;

  /// Who reacted
  final String whoReacted;

  /// Time
  final String time;

  /// Constructs a new ReactionsWidget.
  const ReactionsWidget({
    required this.emoji,
    required this.userName,
    required this.messageReaction,
    required this.whoReacted,
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.2,
            color: Colors.grey.shade400.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Who reacted
          Text(
            '$whoReacted reacted to your message',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),

          ///Reactions Info
          ReactionsInfoWidget(
            emoji: emoji,
            userName: userName,
            messageReaction: messageReaction,
          ),
        ],
      ),
    );
  }
}
