import 'package:flutter/material.dart';
import 'package:slaac/view/bottom_bar/bottom_bar_widget.dart';

/// SlackApp is the main entry point for the Slack app.
class SlackApp extends StatelessWidget {
  /// Constructs a new SlackApp.
  const SlackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slack App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //TODO: Change to OnboardingScreen when it is implemented
      home: const BottomBarWidget(),
    );
  }
}
