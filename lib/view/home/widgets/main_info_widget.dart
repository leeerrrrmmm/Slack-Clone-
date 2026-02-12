import 'package:flutter/material.dart';
import 'package:slaac/view/home/widgets/catch_up_threads_huddle_widget.dart';
import 'package:slaac/view/home/widgets/drop_down_unread_d_ms_info_widget.dart';
import 'package:slaac/view/home/widgets/drow_down_info_widget.dart';
import 'package:slaac/view/home/widgets/next_you_could.dart';

/// MainInfoWidget is the widget that displays the main information of the home screen. */
class MainInfoWidget extends StatefulWidget {
  /// Constructs a new MainInfoWidget.
  const MainInfoWidget({
    super.key,
  });

  @override
  State<MainInfoWidget> createState() => _MainInfoWidgetState();
}

class _MainInfoWidgetState extends State<MainInfoWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        child: const Column(
          spacing: 10,
          children: [
            // Row for the top info block
            Padding(
              padding: EdgeInsets.only(left: 12.0, right: 15.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: CatchUpThreadsHuddleWidget(),
              ),
            ),
            // Divider
            Divider(
              height: 0.4,
              color: Color(0xFFECECEC),
            ),

            //Unread messages(DMS) - ExpansionTile
            DropDownUnreadDMsInfoWidget(title: 'Unread (DMS)'),

            // Divider
            Divider(
              height: 0.4,
              color: Color(0xFFECECEC),
            ),

            //Unread messages(DMS) - ExpansionTile
            DrowDownInfoWidget(
              title: 'Mentioned',
              info: 'helpdesk',
              count: 1,
              infoCount: 2,
              icon: Icons.lock,
            ),

            // Divider
            Divider(
              height: 0.4,
              color: Color(0xFFECECEC),
            ),

            //Unread messages(DMS) - ExpansionTile
            DrowDownInfoWidget(
              title: 'Unread',
              info: 'helpdesk',
              count: 1,
              infoCount: 2,
              icon: Icons.tag,
            ),

            // Divider
            Divider(
              height: 0.4,
              color: Color(0xFFECECEC),
            ),

            //Unread messages(DMS) - ExpansionTile
            DrowDownInfoWidget(
              title: 'Channels',
              info: 'andoid-general',
              count: 4,
              infoCount: 20,
              icon: Icons.tag,
            ),

            // Divider
            Divider(
              height: 0.4,
              color: Color(0xFFECECEC),
            ),

            // Divider
            Divider(
              height: 0.4,
              color: Color(0xFFECECEC),
            ),

            Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12.0),
              child: Column(
                children: [
                  // Next you could... - Clear all
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Next you could...',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Out',
                        ),
                      ),
                      Text(
                        'Clear all',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                          fontFamily: 'Out',
                        ),
                      ),
                    ],
                  ),
                  NextYouCould(
                    title: 'Add teamtes',
                    imageAsset: 'assets/images/addTeam.png',
                    description: 'Bring your whole team together.',
                  ),
                  NextYouCould(
                    title: 'Send a message',
                    imageAsset: 'assets/images/sendMessage.png',
                    description: 'Get the conversation started.',
                  ),
                  NextYouCould(
                    title: 'Get slack for desktop',
                    imageAsset: 'assets/images/getSlack.png',
                    description: 'Stay connected from any device',
                  ),
                  NextYouCould(
                    title: 'See a few tips',
                    imageAsset: 'assets/images/fewTips.png',
                    description: 'Learn the ins and outs of slack.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
