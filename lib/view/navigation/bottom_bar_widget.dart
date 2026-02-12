import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slaac/view/activity/activity_screen.dart';
import 'package:slaac/view/dirrect/dirrect_screen.dart';
import 'package:slaac/view/home/home_screen.dart';
import 'package:slaac/view/more/more_screen.dart';
import 'package:slaac/view/navigation/widgets/bottom_bar_item.dart';
import 'package:slaac/view/navigation/widgets/bottom_buttons.dart';
import 'package:slaac/view/navigation/widgets/bottom_search_button.dart';
import 'package:slaac/view/navigation/widgets/float_action_button_widget.dart';
import 'package:slaac/view/navigation/widgets/tear_bottom_bar_widget.dart';

/// BottomBar is the widget that displays the bottom bar of the app
/// with a draggable "drop" indicator and live icon fill on drag.
class BottomBarWidget extends StatefulWidget {
  /// Constructs a new BottomBarWidget.
  const BottomBarWidget({super.key});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  static const int _tabCount = 4;
  static const double _barBottomMargin = 10;
  static const double _barHeight = 70;
  static const double _dropHitZoneHalfWidth = 20;
  static const Duration _dropSnapDuration = Duration(milliseconds: 250);
  static const double _dropScaleDefault = 1.0;
  static const double _dropScaleWhenDragging = 1.2;
  static const double _fabBottomOffset = 95;
  static const double _fabHorizontalPadding = 15;
  static const double _fillProgressFull = 1.0;
  static const double _fillProgressEmpty = 0.0;

  int index = 0;
  final GlobalKey<HomeScreenState> _homeScreenKey =
      GlobalKey<HomeScreenState>();
  final List<Widget> _pages = [];
  bool isClicked = false;

  final List<GlobalKey> _iconKeys = List.generate(
    _tabCount,
    (_) => GlobalKey(),
  );

  // Drop indicator: размер и смещение по горизонтали
  static const double _dropWidth = 76;
  static const double _dropHeight = 68;
  static const double _indicatorOffset = 12;
  static const double _dropShiftLeft = 16;
  static const int _twoPos = 2;

  double _indicatorLeft = 0;
  double _indicatorWidth = _dropWidth;
  double _indicatorHeight = _dropHeight;

  bool _isDragging = false;
  double _scale = _dropScaleDefault;
  double _dragX = 0;

  double? _minDragX;
  double? _maxDragX;

  double get _normalWidth => _dropWidth;
  double get _normalHeight => _dropHeight;
  double get _bottomPosition =>
      _barBottomMargin + (_barHeight - _normalHeight) / _twoPos;

  List<double> _fillProgresses = List.filled(_tabCount, _fillProgressEmpty);
  List<bool> _fillFromLeft = List.filled(_tabCount, true);

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomeScreen(key: _homeScreenKey),
      const DirrectScreen(),
      const ActivityScreen(),
      const MoreScreen(),
    ]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateDragBounds();
      _updateIndicatorPosition(index);
      _updateFillProgressesFromIndex();
    });
  }

  void _calculateDragBounds() {
    final firstBox =
        _iconKeys.first.currentContext?.findRenderObject() as RenderBox?;
    final lastBox =
        _iconKeys.last.currentContext?.findRenderObject() as RenderBox?;

    if (firstBox != null && lastBox != null) {
      final firstPosition = firstBox.localToGlobal(Offset.zero);
      final lastPosition = lastBox.localToGlobal(Offset.zero);
      _minDragX = firstPosition.dx + _indicatorOffset - _dropShiftLeft;
      _maxDragX =
          lastPosition.dx +
          lastBox.size.width -
          _indicatorOffset -
          _dropShiftLeft;
    }
  }

  void _updateIndicatorPosition(int newIndex) {
    final RenderBox? renderBox =
        _iconKeys[newIndex].currentContext?.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      setState(() {
        _indicatorLeft = position.dx + _indicatorOffset - _dropShiftLeft;
        _dragX = _indicatorLeft;
        _indicatorWidth = _normalWidth;
        _indicatorHeight = _normalHeight;
        _scale = _dropScaleDefault;
      });
    }
  }

  void _updateFillProgressesFromIndex() {
    setState(() {
      for (int i = 0; i < _tabCount; i++) {
        _fillProgresses[i] = index == i
            ? _fillProgressFull
            : _fillProgressEmpty;
        _fillFromLeft[i] = true;
      }
    });
  }

  void _onIndexChanged(int newIndex) {
    setState(() => index = newIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateIndicatorPosition(newIndex);
      _updateFillProgressesFromIndex();
    });
  }

  void _updateFillProgressesFromDrag() {
    final dropLeft = _dragX;
    final dropRight = _dragX + _indicatorWidth;
    final dropCenter = _dragX + _indicatorWidth / 2;
    final newProgresses = List<double>.filled(_tabCount, _fillProgressEmpty);
    final newFromLeft = List<bool>.filled(_tabCount, true);

    for (int i = 0; i < _iconKeys.length; i++) {
      final renderBox =
          _iconKeys[i].currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) continue;

      final position = renderBox.localToGlobal(Offset.zero);
      final iconLeft = position.dx;
      final iconRight = position.dx + renderBox.size.width;
      final iconCenter = position.dx + renderBox.size.width / 2;
      final iconWidth = renderBox.size.width;

      final overlap =
          (dropRight.clamp(iconLeft, iconRight) -
                  dropLeft.clamp(iconLeft, iconRight))
              .clamp(_fillProgressEmpty, iconWidth);
      newProgresses[i] = (overlap / iconWidth).clamp(
        _fillProgressEmpty,
        _fillProgressFull,
      );
      // Fill from left when drop approaches from left
      newFromLeft[i] = dropCenter <= iconCenter;
    }

    if (mounted) {
      setState(() {
        _fillProgresses = newProgresses;
        _fillFromLeft = newFromLeft;
      });
    }
  }

  void _updateIndexFromDrag() {
    for (int i = 0; i < _iconKeys.length; i++) {
      final renderBox =
          _iconKeys[i].currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) continue;

      final position = renderBox.localToGlobal(Offset.zero);
      final centerX = position.dx + renderBox.size.width / 2;
      final dropCenter = _dragX + _indicatorWidth / 2;

      if (dropCenter >= centerX - _dropHitZoneHalfWidth &&
          dropCenter <= centerX + _dropHitZoneHalfWidth) {
        if (index != i) setState(() => index = i);
        break;
      }
    }
  }

  void _snapToIndex() {
    final renderBox =
        _iconKeys[index].currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    setState(() {
      _isDragging = false;
      _scale = _dropScaleDefault;
      _indicatorWidth = _normalWidth;
      _indicatorHeight = _normalHeight;
      _indicatorLeft = position.dx + _indicatorOffset - _dropShiftLeft;
      _dragX = _indicatorLeft;
      _updateFillProgressesFromIndex();
    });
  }

  void _onSearchPressed() {
    if (index == 0) {
      _homeScreenKey.currentState?.toggleSearchField();
    } else {
      setState(() => index = 0);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _homeScreenKey.currentState?.showSearchField();
      });
    }
  }

  void _collapseFAB() {
    if (!isClicked) return;
    setState(() => isClicked = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[index],
          if (isClicked)
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _collapseFAB,
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: BottomButtons(
                    currentIndex: index,
                    onIndexChanged: _onIndexChanged,
                    iconKeys: _iconKeys,
                    fillProgresses: _fillProgresses,
                    fillFromLeft: _fillFromLeft,
                  ),
                ),
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
          ),
          AnimatedPositioned(
            duration: _isDragging ? Duration.zero : _dropSnapDuration,
            curve: Curves.easeOutCubic,
            bottom: _bottomPosition,
            left: _isDragging ? _dragX : _indicatorLeft,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanStart: (_) {
                setState(() {
                  _isDragging = true;
                  _scale = _dropScaleWhenDragging;
                });
              },
              onPanUpdate: (details) {
                final minX = _minDragX;
                final maxX = _maxDragX;
                setState(() {
                  _dragX += details.delta.dx;
                  if (minX != null && maxX != null) {
                    _dragX = _dragX.clamp(minX, maxX);
                  }
                });
                _updateIndexFromDrag();
                _updateFillProgressesFromDrag();
              },
              onPanEnd: (_) => _snapToIndex(),
              child: TearBottomBarWidget(
                scale: _scale,
                isDragging: _isDragging,
                indicatorWidth: _indicatorWidth,
                indicatorHeight: _indicatorHeight,
              ),
            ),
          ),
          Positioned(
            bottom: _fabBottomOffset,
            right: _fabHorizontalPadding,
            left: isClicked ? _fabHorizontalPadding : null,
            child: FloatActionButtonWidget(
              isClicked: isClicked,
              onPressed: () {
                setState(() => isClicked = !isClicked);
              },
            ),
          ),
        ],
      ),
    );
  }
}
