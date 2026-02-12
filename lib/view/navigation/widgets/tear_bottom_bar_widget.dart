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
        settings: LiquidGlassSettings(
          thickness: isDragging ? _thicknessDragging : _thicknessDefault,
          blur: isDragging ? _blurWhenDragging : 0,
          refractiveIndex: isDragging ? 1.15 : 1.08,
          saturation: isDragging ? 1.1 : 0.9,
          ambientStrength: 1,
          glassColor: const Color(0x26FFFFFF),
        ),
        child: LiquidGlass(
          shape: const LiquidOval(),
          child: Container(
            width: indicatorWidth,
            height: indicatorHeight,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
