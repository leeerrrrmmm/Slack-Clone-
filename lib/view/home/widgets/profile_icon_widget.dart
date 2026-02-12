import 'package:flutter/material.dart';

/// ProfileIconWidget is the widget that displays the profile icon.
class ProfileIconWidget extends StatelessWidget {
  /// Constructor
  const ProfileIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 19),
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
    );
  }
}
