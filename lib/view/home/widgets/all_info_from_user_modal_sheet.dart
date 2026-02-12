import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:slaac/data/services/profile_service/profile_photo_service.dart';
import 'package:slaac/view/home/widgets/add_profile_photo_widget.dart';
import 'package:slaac/view/home/widgets/profile_icon_widget.dart';
import 'package:slaac/view/home/widgets/profile_photo_widget.dart';
import 'package:slaac/view/home/widgets/show_preferences_modal_sheet.dart';
import 'package:slaac/view/home/widgets/user_quick_action_button.dart';
import 'package:slaac/view/home/widgets/what_is_your_status_widget.dart';

/// AllInfoFromUserInfoModalSheet is the widget that displays all the info from the user. */
class AllInfoFromUserModalSheet extends StatefulWidget {
  /// Display name
  final String displayName;

  /// Display email
  final String displayEmail;

  /// Constructs a new AllInfoFromUserInfoModalSheet.
  const AllInfoFromUserModalSheet({
    required this.displayName,
    required this.displayEmail,
    super.key,
  });

  @override
  State<AllInfoFromUserModalSheet> createState() =>
      _AllInfoFromUserModalSheetState();
}

class _AllInfoFromUserModalSheetState extends State<AllInfoFromUserModalSheet> {
  File? profilePhoto;

  @override
  void initState() {
    super.initState();
    _loadPhoto();
  }

  Future<void> _loadPhoto() async {
    final photo = await ProfilePhotoService.getSavedPhoto();
    if (photo != null) {
      setState(() => profilePhoto = photo);
    }
  }

  Future<void> _pickPhoto() async {
    final photo = await ProfilePhotoService.pickAndSavePhoto();
    if (photo != null) {
      setState(() => profilePhoto = photo);
    }
  }

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
                    if (profilePhoto != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProfilePhotoWidget(profilePhoto: profilePhoto),
                      )
                    else
                      const ProfileIconWidget(),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.displayName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Out',
                          ),
                        ),
                        Text(
                          widget.displayEmail,
                          style: const TextStyle(
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
                AddProfilePhotoWidget(
                  onTap: _pickPhoto,
                ),

                /// What's Your Status?
                const WhatIsYourStatusWidget(),

                /// Pause notifications
                UserQuickActionButton(
                  iconData: Icons.notifications_off_outlined,
                  title: 'Pause notifications',
                  onTap: () {
                    log('Pause notifications');
                  },
                ),

                /// Set yourself as away
                UserQuickActionButton(
                  iconData: Icons.person_outline,
                  title: 'Set yourseld as away',
                  onTap: () {
                    log('Set yourseld as away');
                  },
                ),

                /// Divider
                const Divider(
                  height: 0.4,
                  color: Color(0xFFECECEC),
                ),

                /// Invitation to connect
                UserQuickActionButton(
                  iconData: Icons.notifications_off_outlined,
                  title: 'Invitation to connect',
                  onTap: () {
                    log('Invitation to connect');
                  },
                ),

                /// View profile
                UserQuickActionButton(
                  iconData: Icons.person_outline_outlined,
                  title: 'View profile',
                  onTap: () {
                    log('View profile');
                  },
                ),

                /// Notifications
                UserQuickActionButton(
                  iconData: Icons.phone_android_sharp,
                  title: 'Notifications',
                  onTap: () {
                    log('Notifications');
                  },
                ),

                /// Preferences
                UserQuickActionButton(
                  iconData: Icons.settings_outlined,
                  title: 'Preferences',
                  onTap: () {
                    log('Preferences');
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (_) => const ShowPreferencesModalSheet(),
                    );
                  },
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
