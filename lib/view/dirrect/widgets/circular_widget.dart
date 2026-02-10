import 'package:flutter/material.dart';

/// CircularWidget is the widget that displays a circular progress indicator.
class CircularWidget extends StatelessWidget {
  /// Constructs a new CircularWidget.
  const CircularWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
