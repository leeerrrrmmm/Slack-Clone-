import 'package:flutter/material.dart';

/// EmptyWidget is the widget that displays an empty state.
class EmptyWidget extends StatelessWidget {
  /// Message of the widget
  final String message;

  /// On tap of the widget
  final void Function()? onTap;

  /// Constructs a new EmptyWidget.
  const EmptyWidget({
    required this.message,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            textAlign: TextAlign.center,
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontFamily: 'Out',
            ),
          ),
        ),
      ),
    );
  }
}
