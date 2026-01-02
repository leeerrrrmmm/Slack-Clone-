import 'package:flutter/material.dart';

/// MoreScreen is the screen that displays the more options of the app.
class MoreScreen extends StatefulWidget {
  /// Constructs a new MoreScreen.
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('More'),
      ),
    );
  }
}
