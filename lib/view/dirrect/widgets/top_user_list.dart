import 'package:flutter/material.dart';

/// TopUserList is the widget that displays the top users of the app.
class TopUserList extends StatelessWidget {
  /// Constructs a new TopUserList.
  const TopUserList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          10,
          (_) => Container(
            margin: const EdgeInsets.only(right: 10),
            width: 100,
            height: 100,
            child: const Column(
              children: [
                Center(child: Icon(Icons.person, size: 40)),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'User\nName',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Out',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
