import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slaac/view/bottom_bar/widgets/bottom_bar_item.dart';

/// BottomButtons is the widget that displays the bottom buttons.
class BottomButtons extends StatelessWidget {
  /// Constructs a new BottomButtons.
  const BottomButtons({
    required this.currentIndex,
    required this.onIndexChanged,
    super.key,
  });

  /// The current selected index.
  final int currentIndex;

  /// Callback function called when index changes.
  final void Function(int) onIndexChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 20,
        bottom: 10,
      ),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          /// Home Button
          Expanded(
            child: BottomBarItem(
              onPressed: () => onIndexChanged(0),
              faIcon: FontAwesomeIcons.house,
              faIconSolid: FontAwesomeIcons.solidHouse,
              isActive: currentIndex == 0,
            ),
          ),

          /// Direct Messages Button
          Expanded(
            child: BottomBarItem(
              onPressed: () => onIndexChanged(1),
              faIcon: FontAwesomeIcons.message,
              faIconSolid: FontAwesomeIcons.solidMessage,
              isActive: currentIndex == 1,
            ),
          ),

          /// Notifications Button
          Expanded(
            child: BottomBarItem(
              onPressed: () => onIndexChanged(2),
              faIcon: FontAwesomeIcons.bell,
              faIconSolid: FontAwesomeIcons.solidBell,
              isActive: currentIndex == 2,
            ),
          ),

          /// More Button
          Expanded(
            child: BottomBarItem(
              onPressed: () => onIndexChanged(3),
              faIcon: FontAwesomeIcons.ellipsis,
              isActive: currentIndex == 3,
            ),
          ),
        ],
      ),
    );
  }
}
