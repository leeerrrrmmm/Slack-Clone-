import 'package:flutter/material.dart';
import 'package:slaac/view/onboarding/onboarding_screen.dart';
import 'package:slaac/view/widgets/logo_widget.dart';

/// OnboardingScreen
class SplashScreen extends StatefulWidget {
  /// Constructs a new OnboardingScreen.
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showMiniElements = false;

  @override
  void initState() {
    super.initState();
    // Показываем mini элементы после того как появятся все большие полосы
    // Последний элемент: delay 800ms + animation 600ms = 1400ms
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) {
        return;
      } else {
        setState(() {
          _showMiniElements = true;
        });
      }
    }).then(
      (_) {
        Future.delayed(
          const Duration(milliseconds: 1000),
          () {
            if (!mounted) {
              return;
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                (_) => false,
              );
            }
          },
        );
      },
    );
  }

  // Slack color palette
  /// Slack blue color
  static const Color slackBlue = Color(0xFF36C5F0);

  /// Slack yellow color
  static const Color slackYellow = Color(0xFFECB22E);

  /// Slack green color
  static const Color slackGreen = Color(0xFF2EB67D);

  /// Slack red color
  static const Color slackRed = Color(0xFFE01E5A);

  // Размеры элементов логотипа
  /// Vertical width
  static const double verticalWidth = 30.0;

  /// Vertical height
  static const double verticalHeight = 60.0;

  /// Horizontal width
  static const double horizontalWidth = 60.0;

  /// Horizontal height
  static const double horizontalHeight = 30.0;

  /// Gap between elements
  static const double gap = 8.0; // Расстояние между элементами

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final centerX = screenSize.width / 2;
    final centerY = screenSize.height / 2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Верхний левый (синий - вертикальный)
          Positioned(
            left: centerX + gap / 2,
            top: centerY - verticalHeight - gap / 2,
            child: const LogoWidget(
              color: slackGreen,
              containerWidth: verticalWidth,
              containerHeight: verticalHeight,
              delay: 200,
            ),
          ),
          // mini green
          Positioned(
            right: centerX - 68,
            top: centerY - 30,
            child: AnimatedOpacity(
              opacity: _showMiniElements ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: slackGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
              ),
            ),
          ),

          // Верхний правый (зеленый - горизонтальный)
          Positioned(
            left: centerX - 60,
            top: centerY - horizontalHeight - gap / 2,
            child: const LogoWidget(
              color: slackBlue,
              containerWidth: horizontalWidth,
              containerHeight: horizontalHeight,
              delay: 400,
            ),
          ),

          // mini blue
          Positioned(
            right: centerX,
            top: centerY - 68,
            child: AnimatedOpacity(
              opacity: _showMiniElements ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: slackBlue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                  ),
                ),
              ),
            ),
          ),

          // Нижний левый (желтый - горизонтальный)
          Positioned(
            left: centerX + gap / 2,
            top: centerY + gap / 2,
            child: const LogoWidget(
              color: slackYellow,
              containerWidth: horizontalWidth,
              containerHeight: horizontalHeight,
              delay: 600,
            ),
          ),
          // mini red
          Positioned(
            right: centerX + 35,
            top: centerY + gap / 2,
            child: AnimatedOpacity(
              opacity: _showMiniElements ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: slackRed,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
              ),
            ),
          ),

          // Нижний правый (красный - вертикальный)
          Positioned(
            left: centerX - 30,
            top: centerY + gap / 2,
            child: const LogoWidget(
              color: slackRed,
              containerWidth: verticalWidth,
              containerHeight: verticalHeight,
              delay: 800,
            ),
          ),
          // mini yellow
          Positioned(
            right: centerX - 35,
            top: centerY + 37,
            child: AnimatedOpacity(
              opacity: _showMiniElements ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: slackYellow,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
