import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/data/services/user_services/fetch_user_service.dart';
import 'package:slaac/view/channel/add_people_to_channel_screen.dart';

/// ChannelInfoModalSheet is the modal sheet that displays the channel info.
class ChannelInfoModalSheet extends StatelessWidget {
  /// Channel ID.
  final String channelId;

  /// Channel Name.
  final String channelName;

  /// Channel Description.
  final String channelDescription;

  /// Channel Image URL.
  final String? channelImageUrl;

  /// Constructs a new ChannelInfoModalSheet.
  const ChannelInfoModalSheet({
    required this.channelId,
    required this.channelName,
    required this.channelDescription,
    this.channelImageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          const _HandleBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ChannelHeader(
                    channelName: channelName,
                    channelImageUrl: channelImageUrl,
                  ),
                  const SizedBox(height: 16),
                  _ChannelDescriptionCard(description: channelDescription),
                  const SizedBox(height: 16),
                  _MemberList(channelId: channelId),
                  const SizedBox(height: 16),
                  _NonMembersList(
                    channelId: channelId,
                    channelName: channelName,
                    channelDescription: channelDescription,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Top handle for modal
class _HandleBar extends StatelessWidget {
  const _HandleBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Center(
        child: Container(
          width: 36,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xFFECECEC),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

/// Channel header: image + name
class _ChannelHeader extends StatelessWidget {
  final String channelName;
  final String? channelImageUrl;

  const _ChannelHeader({required this.channelName, this.channelImageUrl});

  @override
  Widget build(BuildContext context) {
    const size = 72.0;
    final hasImage =
        channelImageUrl != null && (channelImageUrl?.isNotEmpty ?? false);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: hasImage
              ? Image.network(
                  channelImageUrl ?? '',
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const _PlaceholderIImage(size: size),
                )
              : const _PlaceholderIImage(size: size),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            channelName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1D1C1D),
            ),
          ),
        ),
      ],
    );
  }
}

class _PlaceholderIImage extends StatelessWidget {
  final double size;
  const _PlaceholderIImage({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF441045).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.tag_rounded,
        size: 36,
        color: const Color(0xFF441045).withValues(alpha: 0.8),
      ),
    );
  }
}

/// Card with channel description
class _ChannelDescriptionCard extends StatelessWidget {
  final String description;

  const _ChannelDescriptionCard({required this.description});

  @override
  Widget build(BuildContext context) {
    if (description.trim().isEmpty) {
      return const Text(
        'No description',
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFF616061),
          fontStyle: FontStyle.italic,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About this channel',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF616061),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF1D1C1D),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

/// List of current members
class _MemberList extends StatelessWidget {
  final String channelId;
  const _MemberList({required this.channelId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('channels')
          .doc(channelId)
          .snapshots(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final membersIds = List<String>.from(
          (snapshot.data?.data()?['members'] as List<dynamic>?) ?? [],
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Members',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF616061),
              ),
            ),
            const SizedBox(height: 12),
            ...membersIds.map(
              (uid) => FutureBuilder<UserModel?>(
                future: FetchUserService().fetchUserByUid(uid),
                builder: (_, userSnap) {
                  if (!userSnap.hasData) return const SizedBox();
                  final user = userSnap.data;

                  return _MemberTile(user: user);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Tile for single member
class _MemberTile extends StatelessWidget {
  final UserModel? user;
  const _MemberTile({this.user});

  @override
  Widget build(BuildContext context) {
    final name = user?.name ?? 'Unknown';
    final email = user?.email ?? '';
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF441045).withValues(alpha: 0.2),
            child: Text(
              initial,
              style: const TextStyle(
                color: Color(0xFF441045),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (email.isNotEmpty)
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF616061),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// List of non-members + button to add new
class _NonMembersList extends StatelessWidget {
  final String channelId;
  final String channelName;
  final String channelDescription;

  const _NonMembersList({
    required this.channelId,
    required this.channelName,
    required this.channelDescription,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserModel>>(
      stream: FetchUserService().fetchAllUsers(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        final allUsers = snapshot.data ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Non-members',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF616061),
              ),
            ),
            const SizedBox(height: 8),
            ...allUsers.take(5).map((u) => _MemberTile(user: u)),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddPeopleToChannelScreen(
                      channelId: channelId,
                      channelName: channelName,
                      channelDescription: channelDescription,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF441045),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Add new members',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
