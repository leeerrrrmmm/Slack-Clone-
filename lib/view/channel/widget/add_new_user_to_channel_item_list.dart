import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';

/// AddNewUserToChannelItemList is the list of users to add to the channel.
class AddNewUserToChannelItemList extends StatelessWidget {
  /// Constructs a new AddNewUserToChannelItemList.
  const AddNewUserToChannelItemList({
    required this.users,
    required this.selectedUserIds,
    required this.onUserTap,
    super.key,
  });

  /// Users to add to the channel.
  final List<UserModel> users;

  /// Selected user IDs.
  final Set<String> selectedUserIds;

  /// On user tap.
  final void Function(UserModel user) onUserTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: users.length,
      itemBuilder: (_, index) {
        final user = users[index];
        final isSelected = selectedUserIds.contains(user.uid);

        return GestureDetector(
          onTap: () => onUserTap(user),
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFF4EAF7) : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xFF4A154B),
                  child: Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Color(0xFF1D1C1D),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF616061),
                        ),
                      ),
                    ],
                  ),
                ),

                Icon(
                  isSelected
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: const Color(0xFF4A154B),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
