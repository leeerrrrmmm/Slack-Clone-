import 'package:flutter/material.dart';

/// BottomSearchButton is the widget that displays the bottom search button.
class BottomSearchButton extends StatelessWidget {
  /// The child widget to display inside the button.
  final Widget child;

  /// Constructs a new BottomSearchButton.
  const BottomSearchButton({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}
