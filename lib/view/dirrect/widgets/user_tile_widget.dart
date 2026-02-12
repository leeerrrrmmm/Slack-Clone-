import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart' as shimmer_pkg;
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/view/dirrect/chat/chat_screen.dart';

/// UserTileWIdget is the widget that displays a user tile.
class UserTileWIdget extends StatelessWidget {
  /// Constructs a new UserTileWIdget.
  const UserTileWIdget({
    required this.currentUser,
    required this.otherName,
    required this.lastMessage,
    required this.timeStr,
    required this.otherUserId,
    required this.otherEmail,
    this.isLoading = false,
    super.key,
  });

  /// Current user (for navigation to chat and displaying "you" name).
  final UserModel? currentUser;

  /// Other user name.
  final String otherName;

  /// Last message.
  final String lastMessage;

  /// Time string.
  final String timeStr;

  /// Other user ID.
  final String otherUserId;

  /// Other user email.
  final String otherEmail;

  /// When true, shows shimmer placeholders instead of name and message.
  final bool isLoading;

  void _onTap(BuildContext context) {
    if (currentUser == null) return;
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => ChatScreen(
          senderId: currentUser?.uid ?? '',
          senderName: currentUser?.name ?? '',
          senderEmail: currentUser?.email ?? '',
          receiverId: otherUserId,
          receiverName: otherName,
          receiverEmail: otherEmail.isNotEmpty
              ? otherEmail
              : 'unknown@gmail.com',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.person, color: Colors.black),
      ),
      title: _TileTitle(
        currentUserName: currentUser?.name,
        otherName: otherName,
        isLoading: isLoading,
      ),
      subtitle: _TileSubtitle(
        lastMessage: lastMessage,
        isLoading: isLoading,
      ),
      trailing: isLoading
          ? const SizedBox(
              width: 40,
              height: 16,
              child: _ShimmerPlaceholder(width: 36, height: 12),
            )
          : (timeStr.isNotEmpty
                ? Text(
                    timeStr,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontFamily: 'Out',
                    ),
                  )
                : null),
      onTap: isLoading ? null : () => _onTap(context),
    );
  }
}

class _TileTitle extends StatelessWidget {
  const _TileTitle({
    required this.otherName,
    required this.isLoading,
    this.currentUserName,
  });

  final String? currentUserName;
  final String otherName;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (currentUserName != null && !isLoading)
          Text(
            currentUserName ?? '',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Out',
            ),
          ),
        Expanded(
          child: isLoading
              ? const _ShimmerPlaceholder(width: 140, height: 16)
              : Text(
                  otherName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Out',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ],
    );
  }
}

class _TileSubtitle extends StatelessWidget {
  const _TileSubtitle({
    required this.lastMessage,
    required this.isLoading,
  });

  final String lastMessage;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: isLoading
          ? LayoutBuilder(
              builder: (_, constraints) => _ShimmerPlaceholder(
                width: constraints.maxWidth,
              ),
            )
          : Text(
              lastMessage.isEmpty ? 'No messages yet' : lastMessage,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontFamily: 'Out',
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
    );
  }
}

class _ShimmerPlaceholder extends StatelessWidget {
  const _ShimmerPlaceholder({
    required this.width,
    this.height = 14,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return shimmer_pkg.Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
