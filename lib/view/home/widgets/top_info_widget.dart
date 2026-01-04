import 'package:flutter/material.dart';

/// TopInfoWidget is the widget that displays the top info block.
class TopInfoWidget extends StatelessWidget {
  /// The icon of the widget.
  final IconData icon;

  /// The title of the widget.
  final String title;

  /// The number of new items.
  final String number;

  /// The color of the widget.
  final Color color;

  /// The color of the border.
  final Color borderColor;

  /// Constructs a new TopInfoWidget.
  const TopInfoWidget({
    required this.icon,
    required this.title,
    required this.number,
    required this.color,
    required this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(left: 10, top: 10),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 28,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Out',
              ),
            ),
            Text(
              number,
              style: const TextStyle(
                fontFamily: 'Out',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
