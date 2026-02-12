import 'dart:io';

import 'package:flutter/material.dart';

/// ProfilePhotoWidget is the widget that displays the profile photo.
class ProfilePhotoWidget extends StatelessWidget {
  /// Constructor
  const ProfilePhotoWidget({
    required this.profilePhoto,
    super.key,
  });

  /// Profile photo
  final File? profilePhoto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: ClipOval(
        child: Image.file(
          profilePhoto ?? File(''),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
