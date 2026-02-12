import 'dart:io';

import 'package:flutter/material.dart';
import 'package:slaac/data/services/profile_service/profile_photo_service.dart';
import 'package:slaac/view/home/widgets/profile_icon_widget.dart';
import 'package:slaac/view/home/widgets/profile_photo_widget.dart';
import 'package:slaac/view/home/widgets/user_info_modal_sheet.dart';

/// UserInfoButton is the widget that displays the user info button.
class UserInfoButton extends StatefulWidget {
  /// Constructs a new UserInfoButton.
  const UserInfoButton({
    super.key,
  });

  @override
  State<UserInfoButton> createState() => _UserInfoButtonState();
}

class _UserInfoButtonState extends State<UserInfoButton> {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (_) => const UserInfoModalSheet(),
        );
      },
      child: profilePhoto != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProfilePhotoWidget(profilePhoto: profilePhoto),
            )
          : const ProfileIconWidget(),
    );
  }
}
