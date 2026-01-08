import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/view/dirrect/widgets/d_ms_list.dart';
import 'package:slaac/view/dirrect/widgets/top_user_list.dart';

/// DirrectMainInfoWidget is the widget that displays the main information of the dirrect screen. */
class DirrectInfoMainWidget extends StatelessWidget {
  /// The list of users to display.
  final List<UserModel> users;

  /// Constructs a new DirrectMainInfoWidget.
  const DirrectInfoMainWidget({
    required this.users,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          /// Users List
          TopUserList(users: users),

          //DMs List
          const DMsList(),
        ],
      ),
    );
  }
}
