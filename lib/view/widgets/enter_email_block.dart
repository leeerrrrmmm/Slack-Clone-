import 'package:flutter/material.dart';
import 'package:slaac/view/ready_to_launch_screen/ready_to_launch_screen.dart';

/// EnterEmailBlock is the widget that builds the email input block.
class EnterEmailBlock extends StatefulWidget {
  /// Constructs a new EnterEmailBlock.
  const EnterEmailBlock({
    required TextEditingController emailController,
    required BuildContext context,

    /// The email controller.
    super.key,
  }) : _emailController = emailController,
       _context = context;

  final TextEditingController _emailController;
  final BuildContext _context;

  @override
  State<EnterEmailBlock> createState() => _EnterEmailBlockState();
}

class _EnterEmailBlockState extends State<EnterEmailBlock> {
  bool isBtnClicked = false;

  void _onBtnClicked() {
    setState(() {
      isBtnClicked = true;
    });
  }

  void _showNewModal(BuildContext context) {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 20,
          children: [
            // Top info row(close modal bottom sheet & Title)
            Column(
              spacing: 20,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    spacing: 90,
                    children: [
                      IconButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const Text(
                        'Email sent',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Out',
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(
                  height: 0.4,
                  color: Color(0xFFECECEC),
                ),
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    spacing: 20,
                    children: [
                      Image.asset('assets/images/checkEmail.png'),
                      const Text(
                        'Check your email!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Out',
                        ),
                      ),

                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text:
                                  '''To confirm your email, click the link in the email we sent to\t\t''',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Out',
                                color: Color(0xFF5F5F5F),
                              ),
                            ),
                            TextSpan(
                              text: widget._emailController.text,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Out',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  // Open email app button
                  TextButton(
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
                    onPressed: () {
                      // Сначала закрываем модальное окно
                      Navigator.of(context).pop();
                      // Then navigate to the new screen using the parent context */
                      Future.delayed(const Duration(milliseconds: 300), () {
                        if (!widget._context.mounted) return;
                        Navigator.of(widget._context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => const ReadyToLaunchScreen(),
                          ),
                          (_) => false,
                        );
                      });
                    },
                    child: const Text(
                      'Open email app',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Out',
                      ),
                    ),
                  ),

                  // Use password for sign in button
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(
                        double.infinity,
                        50,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Use password for sign in',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Out',
                        color: Color(0xFF007AFF),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        const Text(
          'Enter your email',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Out',
          ),
        ),
        TextField(
          controller: widget._emailController,
          decoration: InputDecoration(
            hintText: 'Enter your email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const Text(
          "We'll send you an email to confirm your address. ",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Out',
          ),
        ),
        TextButton(
          onPressed: () async {
            if (!widget._context.mounted) return;
            // Закрываем текущее модальное окно и ждем полного закрытия
            Navigator.of(context).pop();
            _onBtnClicked();
            // Добавляем небольшую задержку для завершения анимации закрытия
            Future.delayed(const Duration(milliseconds: 300), () {
              if (!widget._context.mounted) {
                return;
              } else {
                _showNewModal(widget._context);
              }
            });
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
            'Sign in with email',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Out',
            ),
          ),
        ),
      ],
    );
  }
}
