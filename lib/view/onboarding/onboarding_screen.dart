import 'package:flutter/material.dart';
import 'package:slaac/view/widgets/onboarding_widgets/first_onboarding_page.dart';
import 'package:slaac/view/widgets/onboarding_widgets/fourth_onboarding_page.dart';
import 'package:slaac/view/widgets/onboarding_widgets/second_onboarding_page.dart';
import 'package:slaac/view/widgets/onboarding_widgets/third_onboarding_page.dart';

/// OnboardingScreen is the screen that displays the onboarding process.
class OnboardingScreen extends StatefulWidget {
  /// Constructs a new OnboardingScreen.
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.all(8),
                width: currentPage == index ? 80 : 60,
                height: 6,
                decoration: BoxDecoration(
                  color: currentPage == index
                      ? Colors.grey.shade400
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          /// PageView
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: 4,
              itemBuilder: (_, index) {
                switch (index) {
                  case 0:
                    return const FirstOnboardingPage();
                  case 1:
                    return const SecondOnboardingPage();
                  case 2:
                    return const ThirdOnboardingPage();
                  case 3:
                    return const FourthOnboardingPage();
                  default:
                    return Container();
                }
              },
            ),
          ),
          if (currentPage != 3)
            TextButton(
              onPressed: () {
                _pageController.animateToPage(
                  3,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Out',
                  color: Color(0xFF69406A),
                ),
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
