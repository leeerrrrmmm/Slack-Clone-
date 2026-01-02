import 'package:flutter/material.dart';
import 'package:slaac/view/home/widgets/top_info_widget.dart';

/// CatchUpThreadsHuddleWidget is the widget that displays the catch up,
/// threads, and huddle information.
class CatchUpThreadsHuddleWidget extends StatelessWidget {
  /// Constructs a new CatchUpThreadsHuddleWidget.
  const CatchUpThreadsHuddleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      spacing: 10,
      children: [
        // Useful information widget
        TopInfoWidget(
          icon: Icons.view_carousel_rounded,
          title: 'Catch up',
          number: '5 new',
          color: Color(0xFFECE7EC),
          borderColor: Color(0xFFDACFDA),
        ),
        TopInfoWidget(
          icon: Icons.chat_bubble_rounded,
          title: 'Threads',
          number: '1 mention',
          color: Color(0xFFECE7EC),
          borderColor: Color(0xFFDACFDA),
        ),
        TopInfoWidget(
          icon: Icons.headset,
          title: 'Huddles',
          number: '1 live',
          color: Color(0xFFECE7EC),
          borderColor: Color(0xFFDACFDA),
        ),
        TopInfoWidget(
          icon: Icons.bookmark_border_rounded,
          title: 'Later',
          number: '2 item',
          color: Colors.white,
          borderColor: Color(0xFFDACFDA),
        ),
        TopInfoWidget(
          icon: Icons.send_outlined,
          title: 'Draft & Sent',
          number: '0 items',
          color: Colors.white,
          borderColor: Color(0xFFDACFDA),
        ),
      ],
    );
  }
}
