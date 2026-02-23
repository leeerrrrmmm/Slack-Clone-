import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slaac/data/services/channel_service/channel_service.dart';
import 'package:slaac/view/channel/widget/channel_info_modal_sheet.dart';
import 'package:slaac/view/channel/widget/channel_input_bar.dart';
import 'package:slaac/view/channel/widget/channel_message_list.dart';

/// ChannelChatScreen is the screen that displays the channel chat screen.
class ChannelChatScreen extends StatefulWidget {
  /// Constructs a new ChannelChatScreen.
  final String channelId;

  /// Channel Name.
  final String channelName;

  /// Channel Members.
  final List<String> channelMembers;

  /// Channel Last Message.
  final String channelLastMessage;

  /// Channel Last Message Timestamp.
  final Timestamp channelLastMessageTimestamp;

  /// Channel Last Message Sender.
  final String channelLastMessageSender;

  /// Channel Last Message Sender Name.
  final String channelLastMessageSenderName;

  /// Channel Last Message Sender Email.
  final String channelLastMessageSenderEmail;

  /// Channel description (for info modal).
  final String channelDescription;

  /// Optional channel image URL (for info modal).
  final String? channelImageUrl;

  /// Constructs a new ChannelChatScreen.
  const ChannelChatScreen({
    required this.channelId,
    required this.channelName,
    required this.channelMembers,
    required this.channelLastMessage,
    required this.channelLastMessageTimestamp,
    required this.channelLastMessageSender,
    required this.channelLastMessageSenderName,
    required this.channelLastMessageSenderEmail,
    this.channelDescription = '',
    this.channelImageUrl,
    super.key,
  });

  @override
  State<ChannelChatScreen> createState() => _ChannelChatScreenState();
}

class _ChannelChatScreenState extends State<ChannelChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChannelService _channelService = ChannelService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _markChannelAsRead();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getChannelStream(
    String channelId,
  ) {
    return FirebaseFirestore.instance
        .collection('channels')
        .doc(channelId)
        .snapshots();
  }

  void _markChannelAsRead() {
    _channelService.markChannelAsRead(widget.channelId);
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final user = _auth.currentUser;
    if (user == null) return;

    try {
      await _channelService.sendMessageToChannel(
        widget.channelId,
        text,
        memberIds: widget.channelMembers,
      );
      _messageController.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending message: $e')),
        );
      }
    }
  }

  void _openChannelInfo() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ChannelInfoModalSheet(
        channelId: widget.channelId,
        channelName: widget.channelName,
        channelDescription: widget.channelDescription,
        channelImageUrl: widget.channelImageUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lastPreview = _buildLastMessagePreview();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF441045),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: InkWell(
          onTap: _openChannelInfo,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        widget.channelName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Out',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white70,
                      size: 22,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  lastPreview,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.85),
                    fontFamily: 'Out',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ChannelMessageList(
              channelService: _channelService,
              channelId: widget.channelId,
              currentUserId: _auth.currentUser?.uid,
            ),
          ),
          ChannelInputBar(
            messageController: _messageController,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }

  String _buildLastMessagePreview() {
    final name = widget.channelLastMessageSenderName;
    final msg = widget.channelLastMessage;
    if (name.isEmpty && msg.isEmpty) return 'No messages yet';
    if (msg.isEmpty) return 'Last: $name';

    return 'Last: $name: $msg';
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
