import 'package:flutter/material.dart';

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
    return const Scaffold(
      body: Center(
        child: Text('Direct Messages'),
      ),
    );
  }
}
