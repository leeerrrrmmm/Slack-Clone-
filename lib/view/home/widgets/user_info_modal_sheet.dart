import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/data/services/user_services/fetch_user_service.dart';
import 'package:slaac/view/home/widgets/all_info_from_user_modal_sheet.dart';

/// UserInfoModalSheet is the widget that displays the user info modal sheet.
class UserInfoModalSheet extends StatefulWidget {
  /// Constructs a new UserInfoModalSheet.
  const UserInfoModalSheet({
    super.key,
  });

  @override
  State<UserInfoModalSheet> createState() => _UserInfoModalSheetState();
}

class _UserInfoModalSheetState extends State<UserInfoModalSheet> {
  final FetchUserService _fetchUserService = FetchUserService();

  @override
  Widget build(BuildContext context) {
    // Get email from FirebaseAuth as fallback
    final currentUserEmail = FirebaseAuth.instance.currentUser?.email ?? '';

    return FutureBuilder<UserModel>(
      future: _fetchUserService.fetchCurrentUser(),
      builder: (_, snapshot) {
        // Use email from FirebaseAuth if user data is not loaded yet
        final userData = snapshot.data;
        final displayEmail = userData != null
            ? userData.email
            : (currentUserEmail.isNotEmpty
                  ? currentUserEmail
                  : 'No email found');

        final displayName = userData != null && userData.name.isNotEmpty
            ? userData.name
            : 'User';

        return AllInfoFromUserModalSheet(
          displayName: displayName,
          displayEmail: displayEmail,
        );
      },
    );
  }
}
