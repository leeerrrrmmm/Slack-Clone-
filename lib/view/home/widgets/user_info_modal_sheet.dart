import 'package:flutter/material.dart';
import 'package:slaac/view/home/widgets/add_profile_photo_widget.dart';
import 'package:slaac/view/home/widgets/user_quick_action_button.dart';
import 'package:slaac/view/home/widgets/what_is_your_status_widget.dart';

/// UserInfoModalSheet is the widget that displays the user info modal sheet.
class UserInfoModalSheet extends StatelessWidget {
  /// Constructs a new UserInfoModalSheet.
  const UserInfoModalSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        spacing: 5,
        children: [
          /// Back Button and Title
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(width: 100),
              const Text(
                'User Info',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Out',
                ),
              ),
            ],
          ),
          // Divider
          const Divider(
            height: 0.4,
            color: Color(0xFFECECEC),
          ),

          /// User Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              spacing: 15,
              children: [
                /// User Photo And Name
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Out',
                          ),
                        ),
                        Text(
                          'john.doe@example.com',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Out',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                /// Add ProfilePhoto Button
                const AddProfilePhotoWidget(),

                /// What's Your Status?
                const WhatIsYourStatusWidget(),

                /// Pause notifications
                const UserQuickActionButton(
                  iconData: Icons.notifications_off_outlined,
                  title: 'Pause notifications',
                ),

                /// Set yourself as away
                const UserQuickActionButton(
                  iconData: Icons.person_outline,
                  title: 'Set yourseld as away',
                ),

                /// Divider
                const Divider(
                  height: 0.4,
                  color: Color(0xFFECECEC),
                ),

                /// Invitation to connect
                const UserQuickActionButton(
                  iconData: Icons.notifications_off_outlined,
                  title: 'Invitation to connect',
                ),

                /// View profile
                const UserQuickActionButton(
                  iconData: Icons.person_outline_outlined,
                  title: 'View profile',
                ),

                /// Notifications
                const UserQuickActionButton(
                  iconData: Icons.phone_android_sharp,
                  title: 'Notifications',
                ),

                /// Preferences
                const UserQuickActionButton(
                  iconData: Icons.settings_outlined,
                  title: 'Preferences',
                ),

                /// Divider
                const Divider(
                  height: 0.4,
                  color: Color(0xFFECECEC),
                ),

                /// 30 days free trial
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F5F5).withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xffECECEC),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// 30 days left of free trial
                      const Text(
                        '30 days left of free trial',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Out',
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 25,
                        decoration: BoxDecoration(
                          color: const Color(0xFF441045),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            'Pro',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Out',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
