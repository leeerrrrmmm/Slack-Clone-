import 'package:flutter/material.dart';
import 'package:slaac/view/home/widgets/settings_btn_widget.dart';
import 'package:slaac/view/home/widgets/settings_button_model.dart';

/// PreferencesAllWidgetInfo is the widget that displays the preferences all widget info. */
class PreferencesAllWidgetInfo extends StatelessWidget {
  /// Constructs a new PreferencesAllWidgetInfo.
  const PreferencesAllWidgetInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Notifications
        SettingsBtnWidget(
          title: 'Notifications',
          buttons: [
            SettingsButton(
              iconData: Icons.notifications_outlined,
              title: 'Push notifications',
              onTap: () {
                // TODO: Implement push notifications toggle
              },
            ),
            SettingsButton(
              iconData: Icons.volume_up_outlined,
              title: 'Sound',
              onTap: () {
                // TODO: Implement sound settings
              },
            ),
          ],
        ),

        ///Appearance
        SettingsBtnWidget(
          title: 'Appearance',
          buttons: [
            SettingsButton(
              iconData: Icons.app_registration_outlined,
              title: 'App icon',
              onTap: () {
                // TODO: Implement light mode toggle
              },
            ),
            SettingsButton(
              iconData: Icons.brightness_4_outlined,
              title: 'Color mode',
              onTap: () {
                // TODO: Implement dark mode toggle
              },
            ),
            SettingsButton(
              iconData: Icons.brightness_auto_outlined,
              title: 'System default',
              onTap: () {
                // TODO: Implement system default toggle
              },
            ),
            SettingsButton(
              iconData: Icons.message_outlined,
              title: 'Message display',
              onTap: () {
                // TODO: Implement system default toggle
              },
            ),
          ],
        ),

        ///Accessibility
        SettingsBtnWidget(
          title: 'Accessibility',
          buttons: [
            SettingsButton(
              iconData: Icons.animation,
              title: 'Animations & Haptics',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),
            SettingsButton(
              iconData: Icons.local_fire_department_outlined,
              title: 'Mesasge verbosity',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),
          ],
        ),

        ///Audio, Video & Images
        SettingsBtnWidget(
          title: 'Audio, Video & Images',
          buttons: [
            SettingsButton(
              iconData: Icons.animation,
              title: 'Images & Video',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),
            SettingsButton(
              iconData: Icons.local_fire_department_outlined,
              title: 'Huddles',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),
          ],
        ),

        ///Language & Region
        SettingsBtnWidget(
          title: 'Language & Region',
          buttons: [
            SettingsButton(
              iconData: Icons.language_outlined,
              title: 'Language',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),
            SettingsButton(
              iconData: Icons.access_time_outlined,
              title: 'Time',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),
          ],
        ),

        ///Privacy & Security
        SettingsBtnWidget(
          title: 'Privacy & Security',
          buttons: [
            SettingsButton(
              iconData: Icons.language_outlined,
              title: 'Language',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),
            SettingsButton(
              iconData: Icons.access_time_outlined,
              title: 'Privacy & Policy',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),
            SettingsButton(
              iconData: Icons.access_time_outlined,
              title: 'Account & Settings',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),
          ],
        ),

        ///Privacy & Security
        SettingsBtnWidget(
          title: 'Device & Troubleshooting',
          buttons: [
            SettingsButton(
              iconData: Icons.web_outlined,
              title: 'Browser Application',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),
            SettingsButton(
              iconData: Icons.network_check_sharp,
              title: 'Network Settings',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),

            SettingsButton(
              iconData: Icons.bug_report_outlined,
              title: 'Debug & Reset Cache',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),
            SettingsButton(
              iconData: Icons.help_outline,
              title: 'Help Center',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),
            SettingsButton(
              iconData: Icons.feedback_outlined,
              title: 'Send Feedback',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),
          ],
        ),

        SettingsBtnWidget(
          title: 'About Slack',
          buttons: [
            SettingsButton(
              iconData: Icons.info_outline,
              title: 'Version',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),
            SettingsButton(
              iconData: Icons.library_books_outlined,
              title: 'Librares we use',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),
            SettingsButton(
              iconData: Icons.analytics_outlined,
              title: 'Analytics',
              onTap: () {
                // TODO: Implement accessibility settings
              },
            ),
          ],
        ),
      ],
    );
  }
}
