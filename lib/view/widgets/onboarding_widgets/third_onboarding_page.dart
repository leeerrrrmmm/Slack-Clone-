import 'package:flutter/material.dart';

/// BuildPageWidget is the widget that builds the page view.
class ThirdOnboardingPage extends StatelessWidget {
  /// The index of the page.

  /// Constructs a new BuildPageWidget.
  const ThirdOnboardingPage({
    /// The index of the page.
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Image.asset(
            'assets/images/tOnboarding.jpg',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 40.0,
            bottom: 90,
            left: 8.0,
            right: 8.0,
          ),
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'And brings your team together',
                  style: TextStyle(
                    fontSize: 34,
                    fontFamily: 'Out',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF441045),
                  ),
                ),
                TextSpan(
                  text: ', so they’re just a tap away.',
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
      ],
    );
  }
}
