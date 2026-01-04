import 'package:flutter/material.dart';
import 'package:slaac/view/dirrect/widgets/d_ms_list.dart';
import 'package:slaac/view/dirrect/widgets/top_user_list.dart';

/// DirrectMainInfoWidget is the widget that displays the main information of the dirrect screen. */
class DirrectInfoMainWidget extends StatelessWidget {
  /// Constructs a new DirrectMainInfoWidget.
  const DirrectInfoMainWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: double.infinity,
        child: const Column(
          children: [
            /// Users List
            TopUserList(),

            //DMs List
            DMsList(),
          ],
        ),
      ),
    );
  }
}
