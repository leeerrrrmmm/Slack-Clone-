import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// MoreInfoActionsWidget is the widget that displays the more info actions.
class MoreInfoActionsWidget extends StatelessWidget {
  /// Font Awesome Icon
  final IconData faIcon;

  /// Title
  final String title;

  /// Description
  final String description;

  /// Constructs a new MoreInfoActionsWidget.
  const MoreInfoActionsWidget({
    required this.faIcon,
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///Icon
          Row(
            spacing: 10,
            children: [
              FaIcon(faIcon),

              ///Some More Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Out',
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Out',
                    ),
                  ),
                ],
              ),
            ],
          ),

          ///Pro Purchases
          Container(
            padding: const EdgeInsets.only(
              left: 5,
            ),
            width: 50,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFF441045),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
                          child: Text(
                'PRO ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Out',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
