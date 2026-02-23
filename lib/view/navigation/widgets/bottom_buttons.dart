import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:slaac/view/navigation/widgets/bottom_bar_item.dart';

/// BottomButtons is the widget that displays the bottom buttons.
class BottomButtons extends StatelessWidget {
  /// Constructs a new BottomButtons.
  const BottomButtons({
    required this.currentIndex,
    required this.onIndexChanged,
    this.iconKeys,
    this.fillProgresses,
    this.fillFromLeft,
    super.key,
  });

  /// The current index of the bottom buttons.
  final int currentIndex;

  /// The function to call when the index is changed.
  final void Function(int) onIndexChanged;

  /// Keys for each icon (for measuring position of the drop indicator).
  final List<GlobalKey>? iconKeys;

  /// Fill progress per tab (0.0..1.0) for "live" fill when dragging the drop.
  final List<double>? fillProgresses;

  /// Fill direction per tab: true = left to right, false = right to left.
  final List<bool>? fillFromLeft;

  static const int _tabCount = 4;

  static const double _barHeight = 60;
  static const double _barBorderRadius = 30;
  static const double _defaultFillProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    final progress =
        fillProgresses ?? List.filled(_tabCount, _defaultFillProgress);
    final fromLeft = fillFromLeft ?? List.filled(_tabCount, true);

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: LiquidGlassLayer(
        settings: const LiquidGlassSettings(
          blur: 2,
          refractiveIndex: 1.5,
          ambientStrength: 2,
          glassColor: Color.fromARGB(112, 255, 255, 255),
        ),
        child: LiquidGlass(
          shape: const LiquidRoundedSuperellipse(borderRadius: 30),
          child: Container(
            width: double.infinity,
            height: _barHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_barBorderRadius),
            ),

            child: Row(
              children: [
                Expanded(
                  child: BottomBarItem(
                    key: iconKeys?.first,
                    onPressed: () => onIndexChanged(0),
                    faIcon: FontAwesomeIcons.house,
                    faIconSolid: FontAwesomeIcons.solidHouse,
                    isActive: currentIndex == 0,
                    fillProgress: progress.first,
                    fillFromLeft: fromLeft.first,
                  ),
                ),
                Expanded(
                  child: BottomBarItem(
                    key: iconKeys?[1],
                    onPressed: () => onIndexChanged(1),
                    faIcon: FontAwesomeIcons.message,
                    faIconSolid: FontAwesomeIcons.solidMessage,
                    isActive: currentIndex == 1,
                    fillProgress: progress[1],
                    fillFromLeft: fromLeft[1],
                  ),
                ),
                Expanded(
                  child: BottomBarItem(
                    key: iconKeys?[2],
                    onPressed: () => onIndexChanged(2),
                    faIcon: FontAwesomeIcons.bell,
                    faIconSolid: FontAwesomeIcons.solidBell,
                    isActive: currentIndex == 2,
                    fillProgress: progress[2],
                    fillFromLeft: fromLeft[2],
                  ),
                ),
                Expanded(
                  child: BottomBarItem(
                    key: iconKeys?[3],
                    onPressed: () => onIndexChanged(3),
                    faIcon: FontAwesomeIcons.ellipsis,
                    isActive: currentIndex == 3,
                    fillProgress: progress[3],
                    fillFromLeft: fromLeft[3],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
