import 'package:flutter/material.dart';
import 'package:slaac/view/widgets/enter_email_block.dart';
import 'package:slaac/view/widgets/sign_in_modal_sheet.dart';

/// BuildPageWidget is the widget that builds the page view.
class FourthOnboardingPage extends StatefulWidget {
  /// The index of the page.

  /// Constructs a new BuildPageWidget.
  const FourthOnboardingPage({
    /// The index of the page.
    super.key,
  });

  @override
  State<FourthOnboardingPage> createState() => _FourthOnboardingPageState();
}

class _FourthOnboardingPageState extends State<FourthOnboardingPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 24.0,
            left: 24.0,
            top: 60.0,
          ),
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'That way you can get work done',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'Out',
                  ),
                ),
                TextSpan(
                  text: '\tno matter where you are.',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF441045),
                    fontFamily: 'Out',
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 85.0),
          child: Image.asset(
            'assets/images/foOnboarding.jpg',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: GestureDetector(
            onTap: () {
              if (!context.mounted) {
                return;
              } else {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) => Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 20,
                        children: [
                          // Top info row(close modal bottom sheet & Title)
                          Row(
                            spacing: 80,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.close),
                              ),
                              const Text(
                                'Sign in with email',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Out',
                                ),
                              ),
                            ],
                          ),

                          const Divider(
                            height: 0.4,
                            color: Color(0xFFECECEC),
                          ),
                          // Email input BLOCK
                          EnterEmailBlock(
                            passwordController: _passwordController,
                            emailController: _emailController,
                            context: context,
                          ),

                          const Divider(
                            height: 0.4,
                            color: Color(0xFFECECEC),
                          ),

                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Out',
                            ),
                          ),

                          /// Sign in with password block
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Future.delayed(
                                const Duration(milliseconds: 300),
                                () {
                                  if (!context.mounted) return;
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (_) => const SignInModalSheet(),
                                  );
                                },
                              );
                            },
                            child: Row(
                              spacing: 10,
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.lock),
                                  ),
                                ),
                                const Text(
                                  'Sign in with Password',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Out',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              height: 36,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF441045),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Out',
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
