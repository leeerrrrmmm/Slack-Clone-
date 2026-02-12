import 'package:flutter/material.dart';

/// HuggleOrChannelBtn is the widget that displays the huggle or channel button.
class HuggleOrChannelBtn extends StatelessWidget {
  /// The icon of the button.
  final IconData icon;

  /// The title of the button.
  final String title;

  /// The subtitle of the button.
  final String subtitle;

  /// Constructs a new HuggleOrChannelBtn.
  const HuggleOrChannelBtn({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
