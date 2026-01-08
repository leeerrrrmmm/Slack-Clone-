import 'package:flutter/material.dart';
import 'package:slaac/view/home/widgets/choose_for_company_or_seasonal_widget.dart';
import 'package:slaac/view/home/widgets/header_of_set_your_status_widget.dart';
import 'package:slaac/view/home/widgets/info_add_status_widget.dart';
import 'package:slaac/view/home/widgets/set_up_status_mode.dart';

/// WhatIsYourStatusWidget is the widget that displays the what is your status widget. */
class WhatIsYourStatusWidget extends StatelessWidget {
  /// Constructs a new WhatIsYourStatusWidget.
  const WhatIsYourStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          builder: (_) => SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.9,
            child: const SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                spacing: 10,
                children: [
                  /// Header
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: HeaderOfSetYourStatusWidget(),
                  ),

                  /// Body
                  InfoAddStatusWidget(),

                  ///Divider
                  Divider(
                    color: Color(0xFFECECEC),
                    height: 0.4,
                  ),

                  ///Seasonal
                  ChooseForCompanyOrSeasonalWidget(
                    title: 'Seasonal',
                    statusModes: [
                      SetUpStatusMode(
                        emoji: '🌸',
                        title: 'Tackling energizing spring tasks',
                      ),
                      SetUpStatusMode(
                        emoji: '🌷',
                        title: 'Flowing with spring renewal',
                      ),
                      SetUpStatusMode(
                        emoji: '🌼',
                        title: 'Blooming with fresh energy',
                      ),
                      SetUpStatusMode(
                        emoji: '🍃',
                        title: 'Breathing in spring vibes',
                      ),
                      SetUpStatusMode(
                        emoji: '🌿',
                        title: 'Growing with spring momentum',
                      ),
                    ],
                  ),

                  ///Divider
                  Divider(
                    color: Color(0xFFECECEC),
                    height: 0.4,
                  ),

                  ///Company
                  ChooseForCompanyOrSeasonalWidget(
                    title: 'For INFOSOFT',
                    statusModes: [
                      SetUpStatusMode(
                        emoji: '🤒',
                        title: 'Sick leave',
                      ),
                      SetUpStatusMode(
                        emoji: '📅',
                        title: 'In a meeting',
                      ),
                      SetUpStatusMode(
                        emoji: '🚌',
                        title: 'Commuting',
                      ),
                      SetUpStatusMode(
                        emoji: '🌴',
                        title: 'Vacation',
                      ),
                      SetUpStatusMode(
                        emoji: '🏠',
                        title: 'Working from home',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.grey.shade100.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            spacing: 10,
            children: [
              Icon(
                Icons.sentiment_satisfied_alt_outlined,
                color: Colors.grey.shade600,
              ),
              const Text(
                "What's Your Status?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Out',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
