import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slaac/data/services/channel_service/channel_service.dart';

/// CreateChannelScreen is the screen that displays the create channel screen.
class CreateChannelScreen extends StatefulWidget {
  /// Constructs a new CreateChannelScreen.
  const CreateChannelScreen({super.key});

  @override
  State<CreateChannelScreen> createState() => _CreateChannelScreenState();
}

/// _CreateChannelScreenState is the state that displays the create channel screen./
class _CreateChannelScreenState extends State<CreateChannelScreen> {
  final TextEditingController _channelNameController = TextEditingController();
  final TextEditingController _channelDescriptionController =
      TextEditingController();

  final List<Map<String, dynamic>> _selectedUsers = [];
  void _openUsersBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        final List<Map<String, dynamic>> tempSelectedUsers = List.from(
          _selectedUsers,
        );

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  /// Drag handle
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E5E5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Add people',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1D1C1D),
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFFE5E5E5), height: 1),

                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF4A154B),
                            ),
                          );
                        }

                        final users = snapshot.data?.docs ?? [];

                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: users.length,
                          separatorBuilder: (_, __) => const Divider(
                            color: Color(0xFFF0F0F0),
                            height: 1,
                          ),
                          itemBuilder: (_, index) {
                            final user = users[index];
                            final data = user.data() as Map<String, dynamic>?;
                            final nickname = data?['name'] ?? '';
                            final userId = user.id;

                            final isSelected = tempSelectedUsers.any(
                              (u) => u['id'] == userId,
                            );

                            return InkWell(
                              onTap: () {
                                setModalState(() {
                                  if (isSelected) {
                                    tempSelectedUsers.removeWhere(
                                      (u) => u['id'] == userId,
                                    );
                                  } else {
                                    tempSelectedUsers.add({
                                      'id': userId,
                                      'nickname': nickname,
                                    });
                                  }
                                });
                              },
                              child: Container(
                                color: isSelected
                                    ? const Color(0xFFF4EAF7)
                                    : Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 14,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        nickname as String,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF1D1C1D),
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      const Icon(
                                        Icons.check,
                                        color: Color(0xFF4A154B),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedUsers.clear();
                            _selectedUsers.addAll(
                              List.from(tempSelectedUsers),
                            );
                          });

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A154B),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Add selected people',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _createChannel() async {
    try {
      final channelService = ChannelService();
      await channelService.createChannel(
        _channelNameController.text,
        _selectedUsers.map((u) => u['id'] as String).toList(),
        _channelDescriptionController.text,
      );
      log('Channel created successfully');
    } catch (e) {
      log('Error creating channel: $e');
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final membersText = _selectedUsers.map((u) => u['nickname']).join(', ');

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1D1C1D),
        title: const Text(
          'Create a channel',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1D1C1D),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Name',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(0xFF616061),
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _channelNameController,
                decoration: InputDecoration(
                  hintText: 'e.g. marketing',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
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

              const SizedBox(height: 22),

              const Text(
                'Description (optional)',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(0xFF616061),
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _channelDescriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'What’s this channel about?',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
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

              const SizedBox(height: 28),

              const Text(
                'Members',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(0xFF616061),
                ),
              ),
              const SizedBox(height: 8),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE5E5E5)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  membersText.isEmpty ? 'No members selected' : membersText,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1D1C1D),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                onPressed: _openUsersBottomSheet,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE5E5E5)),
                  foregroundColor: const Color(0xFF4A154B),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.person_add_alt_1),
                label: const Text('Add people'),
              ),

              const SizedBox(height: 36),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _createChannel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A154B),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Create Channel',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
