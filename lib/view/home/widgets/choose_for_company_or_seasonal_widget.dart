import 'package:flutter/material.dart';
import 'package:slaac/view/home/widgets/set_up_status_mode.dart';

/// ChooseForComapanyOrSeasonalWidget is the widget that displays the choose for comapany or seasonal widget. */
class ChooseForCompanyOrSeasonalWidget extends StatelessWidget {
  /// The title to display.
  final String title;

  /// The status modes to display.
  final List<SetUpStatusMode> statusModes;

  /// Constructs a new ChooseForCompanyOrSeasonalWidget.
  const ChooseForCompanyOrSeasonalWidget({
    required this.title,
    required this.statusModes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Out',
                ),
              ),
              ...statusModes.map(
                (statusMode) => SetUpStatusMode(
                  onSelected: statusMode.onSelected,
                  emoji: statusMode.emoji,
                  title: statusMode.title,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
