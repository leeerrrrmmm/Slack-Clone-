import 'package:flutter/material.dart';

/// A model class that represents a settings button.
class SettingsButton {
  /// The icon data to display.
  final IconData iconData;

  /// The title to display.
  final String title;

  /// The on tap callback.
  final VoidCallback? onTap;

  /// Constructs a new SettingsButton.
  const SettingsButton({
    required this.iconData,
    required this.title,
    this.onTap,
  });
}
