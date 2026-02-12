import 'package:flutter/material.dart';
import 'package:slaac/data/model/selected_status.dart';
import 'package:slaac/data/services/user_services/fetch_user_service.dart';
import 'package:slaac/data/services/user_services/set_up_user_status.dart';
import 'package:slaac/view/home/widgets/choose_for_company_or_seasonal_widget.dart';
import 'package:slaac/view/home/widgets/header_of_set_your_status_widget.dart';
import 'package:slaac/view/home/widgets/info_add_status_widget.dart';
import 'package:slaac/view/home/widgets/set_up_status_mode.dart';

/// WhatIsYourStatusWidget is the widget that displays the what is your status widget. */
class WhatIsYourStatusWidget extends StatefulWidget {
  /// Constructs a new WhatIsYourStatusWidget.
  const WhatIsYourStatusWidget({
    super.key,
  });

  @override
  State<WhatIsYourStatusWidget> createState() => _WhatIsYourStatusWidgetState();
}

class _WhatIsYourStatusWidgetState extends State<WhatIsYourStatusWidget> {
  SelectedStatus? _selectedStatus;
  final _fetchUserService = FetchUserService();
  final _setUpUserStatusService = SetUpUserStatusService();

  @override
  void initState() {
    super.initState();
    _loadSavedStatus();
  }

  Future<void> _loadSavedStatus() async {
    try {
      final user = await _fetchUserService.fetchCurrentUser();
      final status = SelectedStatus.fromStatusString(user.status);
      if (mounted) setState(() => _selectedStatus = status);
    } catch (_) {
      // No user or no status — keep default "What's Your Status?"
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await showModalStatusWidget(context);
        if (result == null || !mounted) return;
        final status = result as SelectedStatus;
        try {
          final user = await _fetchUserService.fetchCurrentUser();
          await _setUpUserStatusService.setUpUserStatus(user.uid, status);
          if (mounted) setState(() => _selectedStatus = status);
        } catch (_) {
          if (mounted) setState(() => _selectedStatus = status);
        }
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
              if (_selectedStatus == null)
                Icon(
                  Icons.sentiment_satisfied_alt_outlined,
                  color: Colors.grey.shade600,
                ),
              if (_selectedStatus != null)
                Text(
                  _selectedStatus?.emoji ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Out',
                  ),
                ),
              Text(
                _selectedStatus == null
                    ? "What's Your Status?"
                    : _selectedStatus?.title ?? '',
                style: const TextStyle(
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

  /// Show modal status widget /
  Future<dynamic> showModalStatusWidget(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (_) => SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.9,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            spacing: 10,
            children: [
              /// Header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: HeaderOfSetYourStatusWidget(),
              ),

              /// Body
              const InfoAddStatusWidget(),

              ///Divider
              const Divider(
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
                    onSelected: (emoji, title) {
                      Navigator.pop(
                        context,
                        SelectedStatus(emoji: emoji, title: title),
                      );
                    },
                  ),
                  SetUpStatusMode(
                    onSelected: (emoji, title) {
                      Navigator.pop(
                        context,
                        SelectedStatus(emoji: emoji, title: title),
                      );
                    },
                    emoji: '🌷',
                    title: 'Flowing with spring renewal',
                  ),
                  SetUpStatusMode(
                    onSelected: (emoji, title) {
                      Navigator.pop(
                        context,
                        SelectedStatus(emoji: emoji, title: title),
                      );
                    },
                    emoji: '🌼',
                    title: 'Blooming with fresh energy',
                  ),
                  SetUpStatusMode(
                    onSelected: (emoji, title) {
                      Navigator.pop(
                        context,
                        SelectedStatus(emoji: emoji, title: title),
                      );
                    },
                    emoji: '🍃',
                    title: 'Breathing in spring vibes',
                  ),
                  SetUpStatusMode(
                    onSelected: (emoji, title) {
                      Navigator.pop(
                        context,
                        SelectedStatus(emoji: emoji, title: title),
                      );
                    },
                    emoji: '🌿',
                    title: 'Growing with spring momentum',
                  ),
                ],
              ),

              ///Divider
              const Divider(
                color: Color(0xFFECECEC),
                height: 0.4,
              ),

              ///Company
              ChooseForCompanyOrSeasonalWidget(
                title: 'For INFOSOFT',
                statusModes: [
                  SetUpStatusMode(
                    onSelected: (emoji, title) {
                      Navigator.pop(
                        context,
                        SelectedStatus(emoji: emoji, title: title),
                      );
                    },
                    emoji: '🤒',
                    title: 'Sick leave',
                  ),
                  SetUpStatusMode(
                    onSelected: (emoji, title) {
                      Navigator.pop(
                        context,
                        SelectedStatus(emoji: emoji, title: title),
                      );
                    },
                    emoji: '📅',
                    title: 'In a meeting',
                  ),
                  SetUpStatusMode(
                    onSelected: (emoji, title) {
                      Navigator.pop(
                        context,
                        SelectedStatus(emoji: emoji, title: title),
                      );
                    },
                    emoji: '🚌',
                    title: 'Commuting',
                  ),
                  SetUpStatusMode(
                    onSelected: (emoji, title) {
                      Navigator.pop(
                        context,
                        SelectedStatus(emoji: emoji, title: title),
                      );
                    },
                    emoji: '🌴',
                    title: 'Vacation',
                  ),
                  SetUpStatusMode(
                    onSelected: (emoji, title) {
                      Navigator.pop(
                        context,
                        SelectedStatus(emoji: emoji, title: title),
                      );
                    },
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
  }
}
