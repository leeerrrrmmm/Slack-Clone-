import 'package:flutter/material.dart';

/// WhatIsYourStatusWidget is the widget that displays the what is your status widget. */
class WhatIsYourStatusWidget extends StatelessWidget {
  /// Constructs a new WhatIsYourStatusWidget.
  const WhatIsYourStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey.shade100.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          spacing: 10,
          children: [
            Icon(
              Icons.sentiment_satisfied_alt_outlined,
              color: Colors.grey.shade600,
            ),
            const Text(
              "What's Your Status?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
