import 'package:flutter/material.dart';
import 'package:slaac/view/splash/splash_screen.dart';

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
        fontFamily: 'Out',
      ),
      //TODO: Change to OnboardingScreen when it is implemented
      home: const SplashScreen(),
    );
  }
}
