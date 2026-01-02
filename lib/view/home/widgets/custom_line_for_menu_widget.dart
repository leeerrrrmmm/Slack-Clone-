import 'package:flutter/material.dart';

/// CustomLineForMenuWidget is the widget that displays the custom line for the menu. */
class CustomLineForMenuWidget extends StatelessWidget {
  /// Constructs a new CustomLineForMenuWidget.

  final double width;

  /// The width of the line.
  const CustomLineForMenuWidget({
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFFDACFDA),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
