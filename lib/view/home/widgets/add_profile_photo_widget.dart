import 'dart:developer';

import 'package:flutter/material.dart';

/// AddProfilePhotoWidget is the widget that displays the add profile photo widget. */
class AddProfilePhotoWidget extends StatelessWidget {
  /// Constructs a new AddProfilePhotoWidget.
  const AddProfilePhotoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log('AddProfilePhotoWidget tapped');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
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
                  Icons.photo_camera,
                  color: Colors.grey.shade800,
                  size: 20,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Add Profile Photo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                '''Help your teammates know that they’re talking to the right person.''',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
