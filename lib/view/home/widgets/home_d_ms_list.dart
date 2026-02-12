import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/data/services/chat_service/chat_service.dart';
import 'package:slaac/data/services/user_services/fetch_user_service.dart';
import 'package:slaac/view/dirrect/widgets/circular_widget.dart';
import 'package:slaac/view/dirrect/widgets/empty_widget.dart';
import 'package:slaac/view/home/widgets/unread_dm_chat_item.dart';

/// HomeDMsList is the widget that displays only DMs with unread messages:
/// row with avatar + nickname and purple oval with unread count.
class HomeDMsList extends StatelessWidget {
  /// Current user (for navigation to chat).
  final UserModel? currentUser;

  /// Constructs a new HomeDMsList.
  const HomeDMsList({
    super.key,
    this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    final chatService = ChatService();
    final fetchUserService = FetchUserService();

    return StreamBuilder<QuerySnapshot>(
      stream: chatService.getUnreadUserChats(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) return const CircularWidget();
        final chats = snapshot.data?.docs ?? [];
        if (chats.isEmpty) return const EmptyWidget();

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: chats.length,
          itemBuilder: (_, index) => _UnreadDMRow(
            currentUser: currentUser,
            chatDoc: chats[index],
            fetchUserService: fetchUserService,
          ),
        );
      },
    );
  }
}

class _UnreadDMRow extends StatelessWidget {
  const _UnreadDMRow({
    required this.currentUser,
    required this.chatDoc,
    required this.fetchUserService,
  });

  final UserModel? currentUser;
  final QueryDocumentSnapshot<Object?> chatDoc;
  final FetchUserService fetchUserService;

  @override
  Widget build(BuildContext context) {
    final data = chatDoc.data() as Map<String, dynamic>? ?? {};
    final otherUserId = data['otherUserId'] as String? ?? '';
    final unreadCount = (data['unreadCount'] as num?)?.toInt() ?? 0;

    return FutureBuilder<UserModel?>(
      future: fetchUserService.fetchUserByUid(otherUserId),
      builder: (_, userSnapshot) {
        final otherUser = userSnapshot.data;
        final otherName = otherUser?.name ?? '';
        final otherEmail = otherUser?.email ?? '';

        return UnreadDMChatItem(
          currentUser: currentUser,
          otherName: otherName,
          otherUserId: otherUserId,
          otherEmail: otherEmail,
          unreadCount: unreadCount,
        );
      },
    );
  }
}
