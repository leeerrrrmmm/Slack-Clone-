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
      builder: (_) {
        final List<Map<String, dynamic>> tempSelectedUsers = List.from(
          _selectedUsers,
        ); // копия!

        return StatefulBuilder(
          builder: (context, setModalState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Add Channel Members',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),

                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final users = snapshot.data?.docs ?? [];

                        return ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (_, index) {
                            final user = users[index];
                            final data = user.data() as Map<String, dynamic>?;
                            final nickname = data?['name'] ?? '';
                            final userId = user.id;

                            final isSelected = tempSelectedUsers.any(
                              (u) => u['id'] == userId,
                            );

                            return ListTile(
                              title: Text(
                                nickname as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              trailing: isSelected
                                  ? const Icon(Icons.check, color: Colors.green)
                                  : null,
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
                            );
                          },
                        );
                      },
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedUsers.addAll(
                          List.from(
                            tempSelectedUsers,
                          ),
                        ); // безопасная замена
                      });

                      Navigator.pop(context);
                    },
                    child: const Text('Add Selected Users'),
                  ),

                  const SizedBox(height: 16),
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
  Widget build(BuildContext context) {
    final membersText = _selectedUsers.map((u) => u['nickname']).join(', ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Channel'),
        centerTitle: true,
        backgroundColor: const Color(0xFF441045),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 14,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Create Channel'),

              TextFormField(
                controller: _channelNameController,
                decoration: const InputDecoration(
                  hintText: 'Channel Name',
                  border: OutlineInputBorder(),
                ),
              ),

              TextFormField(
                controller: _channelDescriptionController,
                decoration: const InputDecoration(
                  hintText: 'Channel Description',
                  border: OutlineInputBorder(),
                ),
              ),

              /// MEMBERS CONTAINER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  membersText.isEmpty ? 'No members selected' : membersText,
                ),
              ),

              GestureDetector(
                onTap: _openUsersBottomSheet,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF441045),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Add Channel Members',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: _createChannel,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF441045),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Create Channel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
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
