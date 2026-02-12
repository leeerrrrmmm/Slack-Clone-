import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slaac/view/activity/activity_screen.dart';
import 'package:slaac/view/bottom_bar/widgets/bottom_bar_item.dart';
import 'package:slaac/view/bottom_bar/widgets/bottom_buttons.dart';
import 'package:slaac/view/bottom_bar/widgets/bottom_search_button.dart';
import 'package:slaac/view/bottom_bar/widgets/float_action_button_widget.dart';
import 'package:slaac/view/dirrect/dirrect_screen.dart';
import 'package:slaac/view/home/home_screen.dart';
import 'package:slaac/view/more/more_screen.dart';

/// BottomBar is the widget that displays the bottom bar of the app.
class BottomBarWidget extends StatefulWidget {
  /// Constructs a new BottomBar.
  const BottomBarWidget({super.key});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int index = 0;
  final GlobalKey<HomeScreenState> _homeScreenKey =
      GlobalKey<HomeScreenState>();

  final List<Widget> _pages = [];

  bool isClicked = false;

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomeScreen(key: _homeScreenKey),
      const DirrectScreen(),
      const ActivityScreen(),
      const MoreScreen(),
    ]);
  }

  void _onIndexChanged(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  void _onSearchPressed() {
    // Якщо ми на HomeScreen, перемикаємо поле пошуку
    if (index == 0) {
      _homeScreenKey.currentState?.toggleSearchField();
    } else {
      // Якщо ми на іншій сторінці, переходимо на HomeScreen і показуємо поле по */
      setState(() {
        index = 0;
      });
      // Використовуємо addPostFrameCallback, щоб дочекатися оновлення UI
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _homeScreenKey.currentState?.showSearchField();
      });
    }
  }

  /// При клике на любое место(если FAB открыт) - закрываем FAB
  void _collapseFAB() {
    if (!isClicked) return;
    setState(() => isClicked = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _pages[index],
          if (isClicked)
            ///При клике на любое место(если FAB открыт) - закрываем FAB
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _collapseFAB,
              ),
            ),
        ],
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            flex: 4,
            child: BottomButtons(
              currentIndex: index,
              onIndexChanged: _onIndexChanged,
            ),
          ),

          /// Search Button
          Expanded(
            child: BottomSearchButton(
              child: BottomBarItem(
                onPressed: _onSearchPressed,
                faIcon: FontAwesomeIcons.magnifyingGlass,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatActionButtonWidget(
        isClicked: isClicked,
        onPressed: () {
          setState(() {
            isClicked = !isClicked;
          });
        },
      ),
    );
  }
}
