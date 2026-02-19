import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/data/services/channel_service/channel_service.dart';
import 'package:slaac/data/services/user_services/fetch_user_service.dart';
import 'package:slaac/view/channel/create_channel_screen.dart';
import 'package:slaac/view/dirrect/widgets/empty_widget.dart';
import 'package:slaac/view/home/widgets/unread_channels_row.dart';

/// ChannelsList displays all channels for the current user.
class ChannelsList extends StatelessWidget {
  final UserModel? currentUser;

  const ChannelsList({super.key, this.currentUser});

  @override
  Widget build(BuildContext context) {
    final channelService = ChannelService();
    final fetchUserService = FetchUserService();

    return StreamBuilder<List<QueryDocumentSnapshot<Object?>>>(
      stream: channelService.fetchChannels(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final chats = snapshot.data ?? [];

        if (chats.isEmpty) {
          return EmptyWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateChannelScreen(),
                ),
              );
            },
            message: 'No channels yet.\nTap to create a new channel',
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: chats.length,
          itemBuilder: (_, index) {
            final chatDoc = chats[index];

            // Проверяем, что document ID не пустой
            if (chatDoc.id.isEmpty) return const SizedBox.shrink();

            return UnreadChannelsRow(
              currentUser: currentUser,
              chatDoc: chatDoc,
              fetchUserService: fetchUserService,
            );
          },
        );
      },
    );
  }
}
