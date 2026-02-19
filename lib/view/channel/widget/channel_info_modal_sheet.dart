// ignore_for_file: avoid_returning_widgets

import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/data/services/user_services/fetch_user_service.dart';

/// Modal sheet with channel info: name, description, image, members list.
/// Styled for light theme (Slack-like).
class ChannelInfoModalSheet extends StatefulWidget {
  /// Channel name.
  final String channelName;

  /// Channel description.
  final String channelDescription;

  /// Optional image URL (e.g. from storage). If null, shows placeholder.
  final String? channelImageUrl;

  /// Member user IDs to resolve to names.
  final List<String> memberIds;

  /// Constructs a new ChannelInfoModalSheet.
  const ChannelInfoModalSheet({
    required this.channelName,
    required this.channelDescription,
    this.channelImageUrl,
    required this.memberIds,
    super.key,
  });

  @override
  State<ChannelInfoModalSheet> createState() => _ChannelInfoModalSheetState();
}

class _ChannelInfoModalSheetState extends State<ChannelInfoModalSheet> {
  final FetchUserService _fetchUserService = FetchUserService();
  List<UserModel?> _members = [];
  bool _loading = true;

  static const Color _surface = Colors.white;
  static const Color _divider = Color(0xFFECECEC);
  static const Color _textPrimary = Color(0xFF1D1C1D);
  static const Color _textSecondary = Color(0xFF616061);
  static const Color _accent = Color(0xFF441045);

  @override
  void initState() {
    super.initState();
    _loadMembers();
  }

  Future<void> _loadMembers() async {
    final list = <UserModel?>[];
    for (final uid in widget.memberIds) {
      final user = await _fetchUserService.fetchUserByUid(uid);
      list.add(user);
    }
    if (mounted) {
      setState(() {
        _members = list;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          _buildHandle(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const Divider(height: 24, color: _divider),
                  _buildDescription(),
                  const Divider(height: 24, color: _divider),
                  _buildMembersSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Center(
        child: Container(
          width: 36,
          height: 4,
          decoration: BoxDecoration(
            color: _divider,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final url = widget.channelImageUrl;
    final hasImage = url != null && url.isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildChannelImage(hasImage ? url : null),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.channelName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: _textPrimary,
                  fontFamily: 'Out',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '# ${widget.memberIds.length} members',
                style: const TextStyle(
                  fontSize: 14,
                  color: _textSecondary,
                  fontFamily: 'Out',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChannelImage(String? imageUrl) {
    const size = 72.0;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholderImage(size),
        ),
      );
    }

    return _placeholderImage(size);
  }

  Widget _placeholderImage(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.tag_rounded,
        size: 36,
        color: _accent.withValues(alpha: 0.8),
      ),
    );
  }

  Widget _buildDescription() {
    final desc = widget.channelDescription.trim();
    if (desc.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          'No description',
          style: TextStyle(
            fontSize: 14,
            color: _textSecondary,
            fontStyle: FontStyle.italic,
            fontFamily: 'Out',
          ),
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
            color: _textSecondary,
            fontFamily: 'Out',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          desc,
          style: const TextStyle(
            fontSize: 15,
            color: _textPrimary,
            height: 1.4,
            fontFamily: 'Out',
          ),
        ),
      ],
    );
  }

  Widget _buildMembersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Members',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _textSecondary,
                fontFamily: 'Out',
              ),
            ),
            Text(
              '${_members.length}',
              style: const TextStyle(
                fontSize: 13,
                color: _textSecondary,
                fontFamily: 'Out',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_loading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _members.length,
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            itemBuilder: (_, index) {
              final user = _members[index];

              return _MemberTile(user: user);
            },
          ),
      ],
    );
  }
}

class _MemberTile extends StatelessWidget {
  const _MemberTile({this.user});

  final UserModel? user;

  static const Color _tileBg = Color(0xFFF8F8F8);
  static const Color _textPrimary = Color(0xFF1D1C1D);
  static const Color _textSecondary = Color(0xFF616061);

  @override
  Widget build(BuildContext context) {
    final name = user?.name ?? 'Unknown';
    final email = user?.email ?? '';
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _tileBg,
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
                fontFamily: 'Out',
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
                    color: _textPrimary,
                    fontFamily: 'Out',
                  ),
                ),
                if (email.isNotEmpty)
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 13,
                      color: _textSecondary,
                      fontFamily: 'Out',
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
