import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';

/// TopUserList is the widget that displays the top users of the app.
class TopUserList extends StatelessWidget {
  /// The list of users to display.
  final List<UserModel> users;

  /// Constructs a new TopUserList.
  const TopUserList({
    required this.users,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: users.length,
        itemBuilder: (_, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            width: 100,
            height: 100,
            child: Column(
              children: [
                const Center(child: Icon(Icons.person, size: 40)),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    users[index].name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Out',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
