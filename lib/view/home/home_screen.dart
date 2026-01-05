import 'package:flutter/material.dart';
import 'package:slaac/view/home/widgets/custom_tab.dart';
import 'package:slaac/view/home/widgets/main_info_widget.dart';
import 'package:slaac/view/home/widgets/search_field_widget.dart';
import 'package:slaac/view/home/widgets/sort_and_filter_button.dart';
import 'package:slaac/view/home/widgets/user_info_button.dart';

/// HomeScreen is the screen that displays the home screen.
class HomeScreen extends StatefulWidget {
  /// Constructs a new HomeScreen.
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

/// HomeScreenState is the state of the HomeScreen.
class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showSearchField = false;

  /// Показує поле пошуку з анімацією
  void showSearchField() {
    if (!mounted) return;
    setState(() {
      _showSearchField = true;
    });
    // Автоматично фокусуємо поле пошуку
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      FocusScope.of(context).requestFocus(_focusNode);
      _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: _searchController.text.length),
      );
    });
  }

  /// Ховає поле пошуку з анімацією
  void hideSearchField() {
    if (!mounted) return;
    // Знімаємо фокус з поля пошуку
    FocusScope.of(context).unfocus();
    setState(() {
      _showSearchField = false;
    });
    // Очищаємо поле пошуку
    _searchController.clear();
  }

  /// Перемикає стан поля пошуку
  void toggleSearchField() {
    if (_showSearchField) {
      hideSearchField();
    } else {
      showSearchField();
    }
  }

  /// Перевіряє, чи видиме поле пошуку
  bool isSearchFieldVisible() => _showSearchField;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: _scaffoldKey,

        /// Drawer
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'WORKSPACES',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Out',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        spacing: 10,
                        children: [
                          Image.asset('assets/images/comlog.jpg'),

                          /// Name and Email of Company
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'IntoSoft',
                                style: TextStyle(fontFamily: 'Out'),
                              ),
                              Text(
                                'nextgen@gmail.com',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontFamily: 'Out',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.only(top: 18.0, bottom: 32.0),
                child: Column(
                  spacing: 20,
                  children: [
                    Divider(height: 0.4, color: Color(0xFFECECEC)),
                    CustomTab(
                      title: 'Add Workspace',
                      icon: Icons.add_circle_outline_rounded,
                    ),
                    CustomTab(
                      title: 'Preferences',
                      icon: Icons.settings_outlined,
                    ),
                    CustomTab(
                      title: 'Help',
                      icon: Icons.help_outline_rounded,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        backgroundColor: Colors.white,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            /// App Bar
            SliverAppBar(
              backgroundColor: const Color(0xFF441045),
              expandedHeight: 90.0,
              leading: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                child: Image.asset('assets/images/comlog.jpg'),
              ),
              toolbarHeight: 80,
              leadingWidth: 80,
              title: const Text(
                'INTOSOFT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Out',
                ),
              ),
              actions: const [
                UserInfoButton(),
              ],
            ),

            /// Search and Filter Row
            SliverToBoxAdapter(
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: _showSearchField
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          children: [
                            /// Search Field
                            Expanded(
                              flex: 4,
                              child: SearchFieldWidget(
                                searchController: _searchController,
                                focusNode: _focusNode,
                              ),
                            ),

                            /// Sort and Filter Button
                            const Expanded(
                              child: SortAndFilterButton(),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),

            /// Main Info Widget - Fixed container
            const SliverFillRemaining(
              hasScrollBody: false,
              child: MainInfoWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
