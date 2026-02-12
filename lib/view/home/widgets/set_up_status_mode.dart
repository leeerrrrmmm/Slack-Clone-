import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slaac/data/model/selected_status.dart';
import 'package:slaac/data/services/user_services/set_up_user_status.dart';

/// SetUpStatusMode is the widget that displays the set up status mode.
class SetUpStatusMode extends StatefulWidget {
  /// The emoji to display.
  final String emoji;

  /// The title to display.
  final String title;

  /// The selected status to set up the status.
  final void Function(String emoji, String title) onSelected;

  /// Constructs a new SetUpStatusMode.
  const SetUpStatusMode({
    required this.emoji,
    required this.title,
    required this.onSelected,
    super.key,
  });

  @override
  State<SetUpStatusMode> createState() => _SetUpStatusModeState();
}

class _SetUpStatusModeState extends State<SetUpStatusMode> {
  String? userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () async {
        await SetUpUserStatusService().setUpUserStatus(
          userId ?? '',
          SelectedStatus(emoji: widget.emoji, title: widget.title),
        );
        widget.onSelected(widget.emoji, widget.title);
      },
      child: SizedBox(
        width: 350,
        height: 40,
        child: Row(
          spacing: 10,
          children: [
            const SizedBox(width: 5),
            Text(widget.emoji),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'Out',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
