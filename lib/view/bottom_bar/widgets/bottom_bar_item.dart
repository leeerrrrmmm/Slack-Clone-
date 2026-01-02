import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// BottomBarItem is the widget that displays the bottom bar item.
class BottomBarItem extends StatelessWidget {
  /// The function to call when the button is pressed.
  final void Function()? onPressed;

  /// The icon to display when the button is not active.
  final IconData faIcon;

  /// The icon to display when the button is active.
  final IconData? faIconSolid;

  /// Whether the button is active.
  final bool isActive;

  /// Constructs a new BottomBarItem.
  const BottomBarItem({
    required this.onPressed,
    required this.faIcon,
    this.faIconSolid,
    this.isActive = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final iconToUse = isActive && faIconSolid != null ? faIconSolid : faIcon;

    return IconButton(
      visualDensity: VisualDensity.compact,
      onPressed: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: FaIcon(
        iconToUse,
        color: isActive ? const Color(0xFF441045) : null,
      ),
    );
  }
}
