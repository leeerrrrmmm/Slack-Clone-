import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/view/dirrect/widgets/d_ms_list.dart';
import 'package:slaac/view/dirrect/widgets/top_user_list.dart';

/// DirrectMainInfoWidget is the widget that displays the main information of the dirrect screen. */
class DirrectInfoMainWidget extends StatelessWidget {
  /// The list of users to display.
  final List<UserModel> users;

  /// The current user.
  final UserModel currentUser;

  /// Constructs a new DirrectMainInfoWidget.
  const DirrectInfoMainWidget({
    required this.users,
    required this.currentUser,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: double.infinity,
        child: Column(
          children: [
            /// Users List
            TopUserList(users: users, currentUser: currentUser),

            //DMs List
            const DMsList(),
          ],
        ),
      ),
    );
  }
}
