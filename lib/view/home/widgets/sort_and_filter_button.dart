import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:slaac/view/home/widgets/custom_line_for_menu_widget.dart';

/// SortAndFilterButton is the widget that displays the sort and filter button.
class SortAndFilterButton extends StatelessWidget {
  /// Constructs a new SortAndFilterButton.
  const SortAndFilterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 11,
        right: 11,
        top: 10,
        bottom: 20,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          /// TODO: Implement the tap functionality
          log('tap');
        },
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(
              0xFFDACFDA,
            ).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4,
              children: [
                CustomLineForMenuWidget(width: 20),
                CustomLineForMenuWidget(width: 15),
                CustomLineForMenuWidget(width: 20),
                CustomLineForMenuWidget(width: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
