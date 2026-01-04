import 'package:flutter/material.dart';
import 'package:slaac/view/dirrect/widgets/dirrect_info_main_widget.dart';
import 'package:slaac/view/home/widgets/user_info_button.dart';

/// DirrectScreen is the screen that displays the direct messages of the app.
class DirrectScreen extends StatefulWidget {
  /// Constructs a new DirrectScreen.
  const DirrectScreen({super.key});

  @override
  State<DirrectScreen> createState() => _DirrectScreenState();
}

class _DirrectScreenState extends State<DirrectScreen> {
  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            /// App Bar
            SliverAppBar(
              backgroundColor: Color(0xFF441045),
              expandedHeight: 90.0,
              toolbarHeight: 80,
              leadingWidth: 80,
              title: Text(
                'DMs',
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

            DirrectInfoMainWidget(),
          ],
        ),
      ),
    );
  }
}
