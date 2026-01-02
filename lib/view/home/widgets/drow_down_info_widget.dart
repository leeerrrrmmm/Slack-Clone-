import 'package:flutter/material.dart';

/// DrowDownInfoWidget is the widget that displays the unread information.
class DrowDownInfoWidget extends StatefulWidget {
  /// Title of the widget
  final String title;

  /// Info of the widget
  final String info;

  /// Count of the widget
  final int count;

  /// Count of the info at this channel
  final int infoCount;

  /// Icon of the widget
  final IconData? icon;

  /// Constructs a new DrowDownInfoWidget.
  const DrowDownInfoWidget({
    required this.title,
    required this.info,
    required this.count,
    required this.infoCount,
    this.icon,
    super.key,
  });

  @override
  State<DrowDownInfoWidget> createState() => _DrowDownInfoWidgetState();
}

class _DrowDownInfoWidgetState extends State<DrowDownInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const RoundedRectangleBorder(),
      collapsedShape: const RoundedRectangleBorder(),
      tilePadding: const EdgeInsets.symmetric(horizontal: 12.0),
      childrenPadding: EdgeInsets.zero,
      title: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: List.generate(
        widget.count,
        (_) => SizedBox(
          width: double.infinity,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Profile picture & name
              Row(
                children: [
                  if (widget.icon == null)
                    Container(
                      margin: const EdgeInsets.only(left: 12.0),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(Icons.person),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Icon(widget.icon),
                    ),
                  const SizedBox(width: 10),
                  // Name and message
                  Text(
                    widget.info,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Message count
              if (widget.infoCount > 0)
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Container(
                    width: 30,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFF69406A),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        widget.infoCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
