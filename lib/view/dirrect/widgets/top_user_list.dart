import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/view/dirrect/chat/chat_screen.dart';

/// TopUserList is the widget that displays the top users of the app.
class TopUserList extends StatelessWidget {
  /// The list of users to display.
  final List<UserModel> users;

  /// The current user.
  final UserModel currentUser;

  /// Constructs a new TopUserList.
  const TopUserList({
    required this.users,
    required this.currentUser,
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
          return InkWell(
            onTap: () {
              //TODO: Open chat screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    senderId: currentUser.uid,
                    senderName: currentUser.name,
                    senderEmail: currentUser.email,
                    receiverId: users[index].uid,
                    receiverName: users[index].name,
                    receiverEmail: users[index].email,
                  ),
                ),
              );
            },
            child: Container(
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
            ),
          );
        },
      ),
    );
  }
}
