import 'package:flutter/material.dart';
import 'package:slaac/view/navigation/bottom_bar_widget.dart';
import 'package:slaac/view/onboarding/onboarding_screen.dart';

/// ReadyToLaunchScreen is the screen that displays the ready to launch screen.
class ReadyToLaunchScreen extends StatefulWidget {
  /// Constructs a new ReadyToLaunchScreen.
  const ReadyToLaunchScreen({super.key});

  @override
  State<ReadyToLaunchScreen> createState() => _ReadyToLaunchScreenState();
}

class _ReadyToLaunchScreenState extends State<ReadyToLaunchScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          spacing: 20,
          children: [
            // Top info row(close modal bottom sheet & Title)
            Row(
              spacing: 90,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OnboardingScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.close),
                ),
                const Text(
                  'Get started',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Out',
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const Divider(
              height: 0.4,
              color: Color(0xFFECECEC),
            ),
            const SizedBox(height: 50),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 30,
              children: [
                Image.asset('assets/images/rocketImg.png'),
                const Text(
                  'Ready for laungch?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Out',
                  ),
                ),
                const Text(
                  textAlign: TextAlign.center,
                  '''You’re all ready to start a new Slack workspace for your organization.''',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Out',
                    color: Colors.grey,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BottomBarWidget(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      minimumSize: const Size(
                        double.infinity,
                        50,
                      ),
                      backgroundColor: const Color(0xFF027A48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Get started',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Out',
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 90),
            const Divider(
              height: 0.4,
              color: Color(0xFFECECEC),
            ),
            const Text(
              textAlign: TextAlign.center,
              '''We couldn’t find existing workspaces foe chandashrestha@gmail.com. If that’s a mistake, ask...''',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: 'Out',
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
