import 'package:flutter/material.dart';

/// Widget to display when there are no messages yet
class NoMessageYetWidget extends StatelessWidget {
  /// Constructor
  const NoMessageYetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No messages yet',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontFamily: 'Out',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start a conversation!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
              fontFamily: 'Out',
            ),
          ),
        ],
      ),
    );
  }
}
