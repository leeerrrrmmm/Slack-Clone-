import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/data/services/channel_service/channel_service.dart';
import 'package:slaac/data/services/user_services/fetch_user_service.dart';
import 'package:slaac/view/channel/widget/add_new_user_to_channel_item_list.dart';

/// AddPeopleToChannelScreen is the screen that displays the add people to channel screen./
class AddPeopleToChannelScreen extends StatefulWidget {
  ///Channel ID
  final String channelId;

  /// Constructs a new AddPeopleToChannelScreen.
  final String channelName;

  /// Channel Description.
  final String channelDescription;

  /// Constructs a new AddPeopleToChannelScreen.
  const AddPeopleToChannelScreen({
    required this.channelId,
    required this.channelName,
    required this.channelDescription,
    super.key,
  });

  @override
  State<AddPeopleToChannelScreen> createState() =>
      _AddPeopleToChannelScreenState();
}

/// _AddPeopleToChannelScreenState is the state that displays the add people to channel screen./
class _AddPeopleToChannelScreenState extends State<AddPeopleToChannelScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> selectedUserIds = {};

  Stream<List<UserModel>>? _usersStream;
  UserModel? _currentUser;

  @override
  void initState() {
    super.initState();
    _usersStream = FetchUserService().fetchAllUsers();
    _loadCurrentUser();

    _searchController.addListener(() {
      // ignore: no_empty_block
      setState(() {});
    });
  }

  void _toggleUser(UserModel user) {
    setState(() {
      if (selectedUserIds.contains(user.uid)) {
        selectedUserIds.remove(user.uid);
      } else {
        selectedUserIds.add(user.uid);
      }
    });
  }

  Future<void> _loadCurrentUser() async {
    try {
      final curUser = await FetchUserService().fetchCurrentUser();
      setState(() {
        _currentUser = curUser;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1D1C1D),
        title: Text(
          'Add people to #${widget.channelName}',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            /// CHANNEL INFO CARD
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF4EAF7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#${widget.channelName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFF4A154B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.channelDescription,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF616061),
                    ),
                  ),
                ],
              ),
            ),

            /// SEARCH FIELD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search people',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFF4A154B),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// USERS LIST (placeholder visual)
            Expanded(
              child: StreamBuilder<List<UserModel>>(
                stream: _usersStream,
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF4A154B),
                      ),
                    );
                  }

                  final users = (snapshot.data ?? [] as List<UserModel>)
                      .where((user) => user.uid != _currentUser?.uid)
                      .where(
                        (user) => user.name.toLowerCase().contains(
                          _searchController.text.toLowerCase(),
                        ),
                      )
                      .toList();

                  if (users.isEmpty) {
                    return const Center(
                      child: Text(
                        'No users found',
                        style: TextStyle(color: Color(0xFF616061)),
                      ),
                    );
                  }

                  return AddNewUserToChannelItemList(
                    users: users,
                    selectedUserIds: selectedUserIds,
                    onUserTap: _toggleUser,
                  );
                },
              ),
            ),

            /// BOTTOM BUTTON
            _BottomButton(selectedUserIds: selectedUserIds, widget: widget),
          ],
        ),
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  const _BottomButton({
    required this.selectedUserIds,
    required this.widget,
  });

  final Set<String> selectedUserIds;
  final AddPeopleToChannelScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE5E5E5)),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: selectedUserIds.isEmpty
              ? null
              : () async {
                  try {
                    final channelService = ChannelService();
                    await channelService.addNewMemnerToChannel(
                      widget.channelId,
                      selectedUserIds.toList(),
                    );

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  } catch (e, st) {
                    log('Error adding users: $e\n$st');
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to add users: $e'),
                        ),
                      );
                    }
                  }
                },

          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A154B),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Add to #${widget.channelName}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
