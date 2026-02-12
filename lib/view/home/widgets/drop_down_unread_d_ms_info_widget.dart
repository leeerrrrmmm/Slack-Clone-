import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/data/services/user_services/fetch_user_service.dart';
import 'package:slaac/view/home/widgets/home_d_ms_list.dart';

/// DrowDownInfoWidget is the widget that displays the unread information.
class DropDownUnreadDMsInfoWidget extends StatefulWidget {
  /// Title of the widget
  final String title;

  /// Icon of the widget
  final IconData? icon;

  /// Constructs a new DrowDownUnreadDMsInfoWidget.
  const DropDownUnreadDMsInfoWidget({
    required this.title,
    this.icon,
    super.key,
  });

  @override
  State<DropDownUnreadDMsInfoWidget> createState() =>
      _DropDownUnreadDMsInfoWidgetState();
}

class _DropDownUnreadDMsInfoWidgetState
    extends State<DropDownUnreadDMsInfoWidget> {
  UserModel? _currentUser;
  @override
  void initState() {
    super.initState();
    _laodCurUser();
  }

  Future<void> _laodCurUser() async {
    try {
      final curUser = await FetchUserService().fetchCurrentUser();
      setState(() {
        _currentUser = curUser;
      });
    } catch (e) {
      log(e.toString());
    }
  }

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
          fontFamily: 'Out',
        ),
      ),
      children: [
        HomeDMsList(
          currentUser: _currentUser,
        ),
      ],
    );
  }
}
