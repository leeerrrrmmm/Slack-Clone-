import 'package:flutter/material.dart';
import 'package:slaac/view/home/widgets/user_info_modal_sheet.dart';

/// UserInfoButton is the widget that displays the user info button.
class UserInfoButton extends StatelessWidget {
  /// Constructs a new UserInfoButton.
  const UserInfoButton({
    super.key,
  });

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
      child: Container(
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
    );
  }
}
