import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:slaac/data/model/user_model.dart';
import 'package:slaac/data/services/user_services/fetch_user_service.dart';
import 'package:slaac/view/dirrect/widgets/d_ms_list.dart';
import 'package:slaac/view/dirrect/widgets/top_user_list.dart';
import 'package:slaac/view/home/widgets/user_info_button.dart';

/// DirrectScreen is the screen that displays the direct messages of the app.
class DirrectScreen extends StatefulWidget {
  /// Constructs a new DirrectScreen.
  const DirrectScreen({super.key});

  @override
  State<DirrectScreen> createState() => _DirrectScreenState();
}

class _DirrectScreenState extends State<DirrectScreen> {
  Stream<List<UserModel>>? _usersStream;
  UserModel? _currentUser;

  @override
  void initState() {
    super.initState();
    _usersStream = FetchUserService().fetchAllUsers();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
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
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<List<UserModel>>(
          stream: _usersStream,
          initialData: const [],
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            final users = snapshot.data ?? [];

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                /// App Bar
                const SliverAppBar(
                  backgroundColor: Color(0xFF441045),
                  expandedHeight: 90.0,
                  toolbarHeight: 80,
                  leadingWidth: 80,
                  title: Text(
                    'DMs',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Out',
                    ),
                  ),
                  actions: [
                    UserInfoButton(),
                  ],
                ),

                /// Users List
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: TopUserList(
                      currentUser:
                          _currentUser ??
                          UserModel(
                            uid: '',
                            name: 'Unknown',
                            email: 'unknown@gmail.com',
                            createdAt: DateTime.now(),
                          ),
                      users: users,
                    ),
                  ),
                ),

                /// DMs List
                SliverToBoxAdapter(
                  child: DMsList(
                    currentUser: _currentUser,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
