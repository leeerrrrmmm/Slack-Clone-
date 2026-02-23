import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

/// TearBottomBarWidget — овальная капля с эффектом жидкого стекла.
class TearBottomBarWidget extends StatelessWidget {
  static const Duration _scaleDuration = Duration(milliseconds: 250);
  static const double _thicknessDefault = 20;

  /// При драге — больше толщина и blur, чтобы преломлялся фон (боттом бар).
  static const double _thicknessDragging = 48;
  static const double _blurWhenDragging = 0;

  /// Constructs a new TearBottomBarWidget.
  const TearBottomBarWidget({
    required this.scale,
    required this.isDragging,
    required this.indicatorWidth,
    required this.indicatorHeight,
    super.key,
  });

  /// The scale of the widget.
  final double scale;

  /// Whether the widget is dragging.
  final bool isDragging;

  /// The width of the indicator.
  final double indicatorWidth;

  /// The height of the indicator.
  final double indicatorHeight;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: _scaleDuration,
      curve: Curves.easeOutCubic,
      scale: scale,
      child: LiquidGlassLayer(
        useBackdropGroup: true,
        settings: LiquidGlassSettings(
          thickness: isDragging ? _thicknessDragging : _thicknessDefault,
          blur: isDragging ? _blurWhenDragging : 20,
          lightAngle: 100 * pi,
          refractiveIndex: 1.1,
          saturation: isDragging ? 1.2 : 0.9,
          ambientStrength: 1.2,
          glassColor: const Color(0x26FFFFFF),
        ),
        child: !isDragging
            ? Container(
                margin: const EdgeInsets.only(bottom: 6),
                width: indicatorWidth,
                height: indicatorHeight - 14,
                decoration: BoxDecoration(
                  color: Colors.grey.shade500.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: LiquidGlass(
                  shape: const LiquidRoundedSuperellipse(borderRadius: 70),
                  child: Container(
                    width: indicatorWidth + 14,
                    height: indicatorHeight - 12,
                    color: Colors.transparent,
                  ),
                ),
              ),
      ),
    );
  }
}
