import 'package:flutter/material.dart';

/// CustomTab is a widget that displays a tab with an icon and a text.
class CustomTab extends StatelessWidget {
  /// The title to display.
  final String title;

  /// The icon to display.
  final IconData icon;

  /// Constructs a new CustomTab.
  const CustomTab({
    required this.title,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Row(
        spacing: 10,
        children: [
          Icon(icon, color: const Color(0xFF5F5F5F)),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF5F5F5F),
              fontFamily: 'Out',
            ),
          ),
        ],
      ),
    );
  }
}
