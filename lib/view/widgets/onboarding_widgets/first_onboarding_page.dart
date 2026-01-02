import 'package:flutter/material.dart';

/// BuildPageWidget is the widget that builds the page view.
class FirstOnboardingPage extends StatelessWidget {
  /// The index of the page.

  /// Constructs a new BuildPageWidget.
  const FirstOnboardingPage({
    /// The index of the page.
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0),
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'We call it',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Out',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '\tSlack',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Out',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF441045),
                  ),
                ),
              ],
            ),
          ),
        ),
        Image.asset(
          'assets/images/fOnboarding.jpg',
        ),
      ],
    );
  }
}
