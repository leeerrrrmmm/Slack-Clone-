import 'dart:developer';

import 'package:flutter/material.dart';

/// UserQuickActionButton is the widget that displays the user quick action butt */
class UserQuickActionButton extends StatelessWidget {
  /// The icon data to display.
  final IconData iconData;

  /// The title to display.
  final String title;

  /// Constructs a new UserQuickActionButton.
  const UserQuickActionButton({
    required this.iconData,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        log('User Quick Action Button');
        //Todo: User Quick Action Button
      },
      child: Row(
        spacing: 10,
        children: [
          Icon(
            iconData,
            color: Colors.grey.shade600,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
