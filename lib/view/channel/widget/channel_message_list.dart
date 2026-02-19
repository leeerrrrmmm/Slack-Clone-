import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slaac/data/services/channel_service/channel_service.dart';
import 'package:slaac/view/channel/widget/channel_message_bubble.dart';

/// List of channel messages with stream.
class ChannelMessageList extends StatelessWidget {
  /// Channel service.
  final ChannelService channelService;

  /// Channel id.
  final String channelId;

  /// Current user id (for aligning messages).
  final String? currentUserId;

  /// Constructs a new ChannelMessageList.
  const ChannelMessageList({
    required this.channelService,
    required this.channelId,
    this.currentUserId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: channelService.getChannelMessagesStream(channelId),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data?.docs ?? [];

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: docs.length,
          itemBuilder: (_, index) {
            final data = docs[index].data() as Map<String, dynamic>? ?? {};
            final text = data['text'] as String? ?? '';
            final senderId = data['senderId'] as String? ?? '';
            final senderName = data['senderName'] as String? ?? '';
            final senderEmail = data['senderEmail'] as String? ?? '';
            final timestamp = data['timestamp'] as Timestamp?;
            final isMe = senderId == currentUserId;

            return ChannelMessageBubble(
              text: text,
              senderName: senderName,
              senderEmail: senderEmail,
              isMe: isMe,
              timestamp: timestamp,
            );
          },
        );
      },
    );
  }
}
