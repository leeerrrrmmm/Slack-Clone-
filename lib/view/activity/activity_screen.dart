import 'package:flutter/material.dart';
import 'package:slaac/view/activity/widgets/reactions_widget.dart';
import 'package:slaac/view/home/widgets/user_info_button.dart';

/// ActivityScreen is the screen that displays the activity of the app.
class ActivityScreen extends StatefulWidget {
  /// Constructs a new ActivityScreen.
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  // Заглушка з 11 різними користувачами, повідомленнями та emoji
  final List<Map<String, String>> _mockReactions = [
    {
      'emoji': '❤️‍🔥',
      'userName': 'Leeermm',
      'messageReaction': 'Great job team!',
      'whoReacted': 'Lerm',
      'time': '10:30',
    },
    {
      'emoji': '👍',
      'userName': 'Leeermm',
      'messageReaction': 'I agree with you',
      'whoReacted': 'Alex',
      'time': '11:15',
    },
    {
      'emoji': '🎉',
      'userName': 'Leeermm',
      'messageReaction': 'This is great!',
      'whoReacted': 'Maria',
      'time': '12:00',
    },
    {
      'emoji': '🔥',
      'userName': 'Leeermm',
      'messageReaction': 'This is a great idea',
      'whoReacted': 'Dmytro',
      'time': '13:45',
    },
    {
      'emoji': '💯',
      'userName': 'Leeermm',
      'messageReaction': 'I fully support',
      'whoReacted': 'Anna',
      'time': '14:20',
    },
    {
      'emoji': '🚀',
      'userName': 'Leeermm',
      'messageReaction': 'Forward to new heights!',
      'whoReacted': 'Volodymyr',
      'time': '15:10',
    },
    {
      'emoji': '⭐',
      'userName': 'Leeermm',
      'messageReaction': 'Excellent work everyone!',
      'whoReacted': 'Oksana',
      'time': '16:00',
    },
    {
      'emoji': '💪',
      'userName': 'Leeermm',
      'messageReaction': 'We can do this!',
      'whoReacted': 'Ivan',
      'time': '16:30',
    },
    {
      'emoji': '🎯',
      'userName': 'Leeermm',
      'messageReaction': 'Right on target!',
      'whoReacted': 'Sofia',
      'time': '17:15',
    },
    {
      'emoji': '✨',
      'userName': 'Leeermm',
      'messageReaction': 'Amazing results!',
      'whoReacted': 'Andriy',
      'time': '17:45',
    },
    {
      'emoji': '👏',
      'userName': 'Leeermm',
      'messageReaction': 'Well done team!',
      'whoReacted': 'Yulia',
      'time': '18:20',
    },
  ];

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
                'Activity',
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
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: _mockReactions.map((reaction) {
                      return ReactionsWidget(
                        emoji: reaction['emoji']!,
                        userName: reaction['userName']!,
                        messageReaction: reaction['messageReaction']!,
                        whoReacted: reaction['whoReacted']!,
                        time: reaction['time']!,
                      );
                    }).toList(),
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
