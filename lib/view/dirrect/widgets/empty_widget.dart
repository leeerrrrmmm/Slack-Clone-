import 'package:flutter/material.dart';

/// EmptyWidget is the widget that displays an empty state.
class EmptyWidget extends StatelessWidget {
  /// Constructs a new EmptyWidget.
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Center(
        child: Text(
          'No chats yet',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontFamily: 'Out',
          ),
        ),
      ),
    );
  }
}
