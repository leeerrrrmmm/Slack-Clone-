import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// BottomBarItem is the widget that displays the bottom bar item.
class BottomBarItem extends StatelessWidget {
  static const double _iconSize = 24;
  static const double _fillFadePx = 8.0;
  static const double _fillFadeClampMin = 0.05;
  static const double _fillFadeClampMax = 0.35;
  static const double _smoothstepCoeffA = 3.0;
  static const double _smoothstepCoeffB = 2.0;

  /// The function to call when the button is pressed.
  final void Function()? onPressed;

  /// The icon to display when the button is not active.
  final IconData faIcon;

  /// The icon to display when the button is active.
  final IconData? faIconSolid;

  /// Whether the button is active (fully selected).
  final bool isActive;

  /// Progress of "fill" from 0.0 to 1.0 (e.g. when drop is dragged over).
  final double fillProgress;

  /// When true, fill from left to right; when false, fill from right to left.
  final bool fillFromLeft;

  /// Constructs a new BottomBarItem.
  const BottomBarItem({
    required this.onPressed,
    required this.faIcon,
    this.faIconSolid,
    this.isActive = false,
    this.fillProgress = 0.0,
    this.fillFromLeft = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveSolid = faIconSolid ?? faIcon;
    final showPartialFill = fillProgress > 0 && fillProgress < 1;
    final showFullSolid = isActive || (fillProgress >= 1);

    return IconButton(
      visualDensity: VisualDensity.compact,
      onPressed: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: SizedBox(
        width: _iconSize,
        height: _iconSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            FaIcon(
              showFullSolid && !showPartialFill ? effectiveSolid : faIcon,
              color: showFullSolid && !showPartialFill
                  ? const Color(0xFF441045)
                  : null,
            ),
            if (showPartialFill)
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) {
                  final fade = (_fillFadePx / bounds.width)
                      .clamp(_fillFadeClampMin, _fillFadeClampMax);
                  final t = fillProgress.clamp(0.0, 1.0);
                  final smooth =
                      t * t * (_smoothstepCoeffA - _smoothstepCoeffB * t);
                  final f = smooth;

                  List<double> stops;
                  List<Color> colors;
                  const purple = Color(0xFF441045);
                  const purpleFade = Color(0xE6441045);
                  const purpleTransparent = Color(0x00441045);

                  if (fillFromLeft) {
                    final e0 = (f - fade * 0.5).clamp(0.0, 1.0);
                    final e1 = (f - fade * 0.25).clamp(0.0, 1.0);
                    final e2 = f;
                    final e3 = (f + fade * 0.5).clamp(0.0, 1.0);
                    stops = [0.0, e0, e1, e2, e3, 1.0];
                    colors = [
                      purple,
                      purple,
                      purple,
                      purpleFade,
                      purpleTransparent,
                      purpleTransparent,
                    ];
                  } else {
                    final e0 = (1.0 - f - fade * 0.5).clamp(0.0, 1.0);
                    final e1 = (1.0 - f - fade * 0.25).clamp(0.0, 1.0);
                    final e2 = (1.0 - f).clamp(0.0, 1.0);
                    final e3 = (1.0 - f + fade * 0.5).clamp(0.0, 1.0);
                    stops = [0.0, e0, e1, e2, e3, 1.0];
                    colors = [
                      purpleTransparent,
                      purpleTransparent,
                      purpleFade,
                      purple,
                      purple,
                      purple,
                    ];
                  }

                  return LinearGradient(
                    colors: colors,
                    stops: stops,
                  ).createShader(bounds);
                },
                child: FaIcon(
                  effectiveSolid,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
