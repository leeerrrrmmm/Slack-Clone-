import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/view/channel/channel_chat_screen.dart';

/// UnreadChannelChatItem is the widget that displays the unread channel chat item./

class UnreadChannelChatItem extends StatelessWidget {
  /// The current user. /
  final UserModel? currentUser;

  /// The channel name. /
  final String channelName;

  /// The channel members. /
  final List<String> channelMembers;

  /// Constructs a new UnreadChannelChatItem.
  const UnreadChannelChatItem({
    required this.currentUser,
    required this.channelName,
    required this.channelMembers,
    required this.channelDoc,
    super.key,
  });

  /// The channel document. /
  final QueryDocumentSnapshot channelDoc;

  @override
  Widget build(BuildContext context) {
    final data = channelDoc.data() as Map<String, dynamic>? ?? {};
    // Channel doc comes from collection 'channels' — document ID is the channelId./
    final channelId = channelDoc.id;
    final name = data['channelName'] as String? ?? channelName;
    final members = data['members'] as List<dynamic>?;
    final channelMembersList = members != null
        ? List<String>.from(members.map((e) => e.toString()))
        : channelMembers;
    final lastMsg = data['lastMessage'] as String?;
    final channelLastMessage =
        lastMsg ?? data['channelLastMessage'] as String? ?? '';
    final lastTs = data['lastMessageTimestamp'] as Timestamp?;
    final channelLastMessageTimestamp =
        lastTs ??
        data['channelLastMessageTimestamp'] as Timestamp? ??
        Timestamp.now();
    final channelLastMessageSender =
        data['lastMessageSender'] as String? ??
        data['channelLastMessageSender'] as String? ??
        '';
    final channelLastMessageSenderName =
        data['lastMessageSenderName'] as String? ??
        data['channelLastMessageSenderName'] as String? ??
        '';
    final lastEmail = data['lastMessageSenderEmail'] as String?;
    final channelLastMessageSenderEmail =
        lastEmail ?? data['channelLastMessageSenderEmail'] as String? ?? '';
    final unreadCountsMap = data['unreadCounts'] as Map<String, dynamic>?;
    final currentUid = currentUser?.uid;
    final unreadCount = currentUid != null
        ? (unreadCountsMap?[currentUid] as int? ?? 0)
        : (data['unreadCount'] as int? ?? 0);
    final channelDescription = data['channelDescription'] as String? ?? '';
    final channelImageUrl = data['channelImageUrl'] as String?;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => ChannelChatScreen(
                channelId: channelId,
                channelName: name,
                channelMembers: channelMembersList,
                channelLastMessage: channelLastMessage,
                channelLastMessageTimestamp: channelLastMessageTimestamp,
                channelLastMessageSender: channelLastMessageSender,
                channelLastMessageSenderName: channelLastMessageSenderName,
                channelLastMessageSenderEmail: channelLastMessageSenderEmail,
                channelDescription: channelDescription,
                channelImageUrl: channelImageUrl,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock_outline, color: Colors.black),
                  const SizedBox(width: 12),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Out',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              if (unreadCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF441045),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    unreadCount > 99 ? '99+' : unreadCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Out',
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
