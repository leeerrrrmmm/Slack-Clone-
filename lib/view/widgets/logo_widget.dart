import 'package:flutter/material.dart';

/// LogoWidget is the widget that displays the logo.
class LogoWidget extends StatefulWidget {
  /// Constructs a new LogoWidget.
  const LogoWidget({
    required this.color,
    required this.delay,
    this.containerHeight,
    this.containerWidth,
    super.key,
  });

  /// The height of the container.
  final double? containerHeight;

  /// The width of the container.
  final double? containerWidth;

  /// The color of the container.
  final Color color;

  /// Delay before animation starts (in milliseconds).
  final int delay;

  @override
  State<LogoWidget> createState() => _LogoWidgetState();
}

class _LogoWidgetState extends State<LogoWidget> {
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    // Запускаем анимацию с задержкой
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (!mounted) {
        return;
      } else {
        setState(() {
          _isAnimated = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isAnimated ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.elasticOut,
      child: Container(
        width: widget.containerWidth ?? 20,
        height: widget.containerHeight ?? 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: widget.color,
        ),
      ),
    );
  }
}
