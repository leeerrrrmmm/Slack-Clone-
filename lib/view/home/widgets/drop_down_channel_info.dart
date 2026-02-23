import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/data/services/channel_service/channel_service.dart';
import 'package:slaac/data/services/user_services/fetch_user_service.dart';
import 'package:slaac/view/channel/create_channel_screen.dart';
import 'package:slaac/view/home/widgets/channels_list.dart';

/// DrowDownInfoWidget is the widget that displays the unread information.
class DropDownChannelInfo extends StatefulWidget {
  /// Title of the widget
  final String title;

  /// Icon of the widget
  final IconData? icon;

  /// Constructs a new DrowDownUnreadDMsInfoWidget.
  const DropDownChannelInfo({
    required this.title,
    this.icon,
    super.key,
  });

  @override
  State<DropDownChannelInfo> createState() => _DropDownChannelInfoState();
}

class _DropDownChannelInfoState extends State<DropDownChannelInfo> {
  UserModel? _currentUser;

  @override
  void initState() {
    super.initState();
    _laodCurUser();
  }

  Future<void> _laodCurUser() async {
    try {
      final curUser = await FetchUserService().fetchCurrentUser();
      if (!mounted) return;
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
      // children: [
      //   ChannelsList(
      //     currentUser: _currentUser,
      //   ),
      //   const SizedBox(height: 15),
      //   const Padding(
      //     padding: EdgeInsets.only(left: 8.0),
      //     child: Row(
      //       children: [
      //         Icon(Icons.add, color: Colors.black),
      //         Text(
      //           'Create Channel',
      //           style: TextStyle(
      //             fontFamily: 'Out',
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ],
      children: [
        StreamBuilder<List<QueryDocumentSnapshot>>(
          stream: ChannelService().fetchChannels(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            final channels = snapshot.data ?? [];

            return Column(
              children: [
                ChannelsList(
                  currentUser: _currentUser,
                ),
                const SizedBox(height: 15),

                if (channels.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CreateChannelScreen(),
                          ),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.add, color: Colors.black),
                          Text(
                            'Create Channel',
                            style: TextStyle(
                              fontFamily: 'Out',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
