import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/data/services/chat_service/chat_service.dart';
import 'package:slaac/data/services/user_services/fetch_user_service.dart';
import 'package:slaac/view/dirrect/widgets/chat_list_item.dart';
import 'package:slaac/view/dirrect/widgets/circular_widget.dart';
import 'package:slaac/view/dirrect/widgets/empty_widget.dart';

/// DMsList is the widget that displays the list of DMs.
class DMsList extends StatelessWidget {
  /// Current user (for navigation to chat and displaying "you" name).
  final UserModel? currentUser;

  /// Constructs a new DMsList.
  const DMsList({
    super.key,
    this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    final chatService = ChatService();
    final fetchUserService = FetchUserService();

    return StreamBuilder<QuerySnapshot>(
      stream: chatService.getUserChats(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) return const CircularWidget();
        final chats = snapshot.data?.docs ?? [];
        if (chats.isEmpty) return const EmptyWidget();

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: chats.length,
          itemBuilder: (_, index) => ChatListItem(
            currentUser: currentUser,
            chatDoc: chats[index],
            fetchUserService: fetchUserService,
          ),
        );
      },
    );
  }
}
