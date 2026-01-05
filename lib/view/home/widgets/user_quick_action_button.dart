import 'package:flutter/material.dart';

/// UserQuickActionButton is the widget that displays the user quick action butt */
class UserQuickActionButton extends StatelessWidget {
  /// The icon data to display.
  final IconData iconData;

  /// The title to display.
  final String title;

  /// The on tap function.
  final Function()? onTap;

  /// Constructs a new UserQuickActionButton.
  const UserQuickActionButton({
    required this.iconData,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: SizedBox(
          width: 330,
          height: 30,
          child: Row(
            spacing: 10,
            children: [
              const SizedBox(width: 5),
              Icon(
                iconData,
                color: Colors.grey.shade600,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                  fontFamily: 'Out',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
