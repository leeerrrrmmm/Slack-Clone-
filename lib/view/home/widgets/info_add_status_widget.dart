import 'dart:developer';

import 'package:flutter/material.dart';

/// InfoAddStatusWidget is the widget that displays the info add status widget.
class InfoAddStatusWidget extends StatelessWidget {
  /// Constructs a new InfoAddStatusWidget.
  const InfoAddStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log('AddProfilePhotoWidget tapped');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        width: double.infinity,
        height: 92,
        decoration: BoxDecoration(
          color: const Color(0xFFDFF2FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),

            /// Add Profile Photo Label
            Row(
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
            ),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                '''Set and clear your status right from your\nmobile.''',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Out',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
