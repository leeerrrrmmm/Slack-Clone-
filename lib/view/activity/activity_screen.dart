import 'package:flutter/material.dart';

/// ActivityScreen is the screen that displays the activity of the app.
class ActivityScreen extends StatefulWidget {
  /// Constructs a new ActivityScreen.
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Activity'),
      ),
    );
  }
}
