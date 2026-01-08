import 'package:flutter/material.dart';

/// AddStatusWidget is the widget that displays the add status widget.
class AddStatusWidget extends StatelessWidget {
  /// Constructs a new AddStatusWidget.
  const AddStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.sentiment_satisfied_alt_outlined,
          color: Colors.grey.shade800,
          size: 20,
        ),
        const SizedBox(width: 10),
        const Text(
          'Add the Status widget',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Out',
          ),
        ),
      ],
    );
  }
}
