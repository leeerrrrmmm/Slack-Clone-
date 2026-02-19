import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/data/services/user_services/fetch_user_service.dart';
import 'package:slaac/view/home/widgets/unread_channel_chat_item.dart';

/// UnreadChannelsRow is the widget that displays the unread channels row.
class UnreadChannelsRow extends StatelessWidget {
  /// Constructs a new UnreadChannelsRow.
  const UnreadChannelsRow({
    required this.currentUser,
    required this.chatDoc,
    required this.fetchUserService,
    super.key,
  });

  /// Current user (for navigation to chat).
  final UserModel? currentUser;

  /// Chat document.
  final QueryDocumentSnapshot<Object?> chatDoc;

  /// Fetch user service.
  final FetchUserService fetchUserService;

  @override
  Widget build(BuildContext context) {
    final data = chatDoc.data() as Map<String, dynamic>? ?? {};
    final channelName = data['channelName'] as String? ?? '';
    final channelMembers = data['members'] != null
        ? List<String>.from(data['members'] as Iterable<dynamic>)
        : <String>[];

    return UnreadChannelChatItem(
      currentUser: currentUser,
      channelName: channelName,
      channelMembers: channelMembers,
      channelDoc: chatDoc,
    );
  }
}
