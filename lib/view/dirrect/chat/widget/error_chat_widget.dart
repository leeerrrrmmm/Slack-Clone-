import 'package:flutter/material.dart';

/// Widget to display when there is an error
class ErrorChatWidget extends StatelessWidget {
  /// Constructor
  const ErrorChatWidget({
    required this.error,
    super.key,
  });

  /// Error message
  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Error: ${error ?? "Unknown error"}',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
