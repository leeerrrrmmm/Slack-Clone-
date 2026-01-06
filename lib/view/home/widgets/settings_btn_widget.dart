import 'package:flutter/material.dart';
import 'package:slaac/view/home/widgets/settings_button.dart';
import 'package:slaac/view/home/widgets/user_quick_action_button.dart';

/// A widget that displays a settings button.
class SettingsBtnWidget extends StatefulWidget {
  /// The title of the settings button.
  final String title;

  /// The buttons to display.
  final List<SettingsButton> buttons;

  /// Constructs a new SettingsBtnWidget.
  const SettingsBtnWidget({
    required this.title,
    required this.buttons,
    super.key,
  });

  @override
  State<SettingsBtnWidget> createState() => _SettingsBtnWidgetState();
}

class _SettingsBtnWidgetState extends State<SettingsBtnWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Out',
                  ),
                ),
                ...widget.buttons.map(
                  (button) => UserQuickActionButton(
                    iconData: button.iconData,
                    title: button.title,
                    onTap: button.onTap,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
