import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slaac/view/home/widgets/user_info_button.dart';
import 'package:slaac/view/more/widgets/more_info_actions_widget.dart';

/// MoreScreen is the screen that displays the more of the app.
class MoreScreen extends StatefulWidget {
  /// Constructs a new MoreScreen.
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            /// App Bar
            const SliverAppBar(
              backgroundColor: Color(0xFF441045),
              expandedHeight: 90.0,
              toolbarHeight: 80,
              leadingWidth: 80,
              title: Text(
                'More',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Out',
                ),
              ),
              actions: [
                UserInfoButton(),
              ],
            ),

            SliverFillRemaining(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                width: double.infinity,
                child: const SingleChildScrollView(
                  child: Column(
                    spacing: 20,
                    children: [
                      MoreInfoActionsWidget(
                        faIcon: FontAwesomeIcons.pager,
                        title: 'Canvases',
                        description: 'Currate countent and collaborate',
                      ),
                      MoreInfoActionsWidget(
                        faIcon: FontAwesomeIcons.listCheck,
                        title: 'Lists',
                        description: 'Track and manage projects',
                      ),
                      MoreInfoActionsWidget(
                        faIcon: FontAwesomeIcons.peopleGroup,
                        title: 'Assigned to you',
                        description: 'Tick off your tasks',
                      ),
                      MoreInfoActionsWidget(
                        faIcon: FontAwesomeIcons.building,
                        title: 'External connections',
                        description:
                            'Work with people from other organisations',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
