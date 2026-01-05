import 'package:flutter/material.dart';

/// SetUpStatusMode is the widget that displays the set up status mode.
class SetUpStatusMode extends StatelessWidget {
  /// The emoji to display.
  final String emoji;

  /// The title to display.
  final String title;

  /// Constructs a new SetUpStatusMode.
  const SetUpStatusMode({
    required this.emoji,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        // TODO: Implement the on tap functionality.
      },
      child: SizedBox(
        width: 350,
        height: 40,
        child: Row(
          spacing: 10,
          children: [
            const SizedBox(width: 5),
            Text(emoji),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'Out',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
