import 'package:flutter/material.dart';

/// BuildPageWidget is the widget that builds the page view.
class SecondOnboardingPage extends StatelessWidget {
  /// The index of the page.

  /// Constructs a new BuildPageWidget.
  const SecondOnboardingPage({
    /// The index of the page.
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 40.0,
            bottom: 90,
          ),
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'It keeps things on topic, ',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF441045),
                    fontFamily: 'Out',
                  ),
                ),
                TextSpan(
                  text: 'by giving each project a\nspace of its own.',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'Out',
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Image.asset(
            'assets/images/sOnboarding.jpg',
          ),
        ),
      ],
    );
  }
}
