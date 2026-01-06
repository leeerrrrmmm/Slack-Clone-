import 'package:flutter/material.dart';
import 'package:slaac/view/widgets/circular_custom_button.dart';

/// HeaderOfSetYourStatusWidget is the widget that displays the header of set yor */
class HeaderOfSetYourStatusWidget extends StatelessWidget {
  /// Constructor
  const HeaderOfSetYourStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularCustomButton(
          onTap: () => Navigator.pop(context),
          icon: Icons.arrow_back_outlined,
          color: const Color(0xFF441045),
        ),
        const Spacer(),

        const Text(
          "Set a Status?",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: 'Out',
          ),
        ),
        const Spacer(),
        CircularCustomButton(
          onTap: () {
            //TODO: Implement SAVE login
          },
          icon: Icons.done,
          color: const Color(0xFF441045),
        ),
      ],
    );
  }
}
