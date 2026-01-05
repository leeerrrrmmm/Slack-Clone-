import 'package:flutter/material.dart';

/// Circular Custom Button
class CircularCustomButton extends StatelessWidget {
  /// On Tap
  final void Function()? onTap;

  /// Icon
  final IconData icon;

  /// Color
  final Color color;

  /// Constructor
  const CircularCustomButton({
    required this.onTap,
    required this.icon,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: color,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
