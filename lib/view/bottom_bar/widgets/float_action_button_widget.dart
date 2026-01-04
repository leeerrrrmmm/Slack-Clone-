import 'package:flutter/material.dart';
import 'package:slaac/view/bottom_bar/widgets/huggle_or_channel_btn.dart';

/// FloatActionButtonWidget is the widget that displays the floating action button. */
class FloatActionButtonWidget extends StatefulWidget {
  /// The function to call when the button is pressed.
  final void Function()? onPressed;

  /// The state of the button.
  final bool isClicked;

  /// Constructs a new FloatActionButtonWidget.
  const FloatActionButtonWidget({
    required this.onPressed,
    required this.isClicked,
    super.key,
  });

  @override
  State<FloatActionButtonWidget> createState() =>
      _FloatActionButtonWidgetState();
}

class _FloatActionButtonWidgetState extends State<FloatActionButtonWidget> {
  static const Duration _animationDuration = Duration(milliseconds: 800);
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    if (widget.isClicked) {
      _showContentAfterAnimation();
    }
  }

  void _showContentAfterAnimation() {
    if (_showContent) {
      _showContent = false;
    }
    //Wait till the animation is completed
    Future.delayed(_animationDuration, () {
      if (!mounted || !widget.isClicked || _showContent) {
        return;
      }
      setState(() {
        _showContent = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.isClicked ? 220.0 : 60.0;
    final width = widget.isClicked
        ? MediaQuery.of(context).size.width - 30
        : 60.0;

    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: _animationDuration,
        curve: Curves.easeInOut,
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.isClicked
                ? const Color(0xFF441045)
                : Colors.grey.shade300,
          ),
          color: widget.isClicked
              ? Colors.grey.shade100
              : const Color(0xFF441045),
          borderRadius: BorderRadius.circular(
            widget.isClicked ? 10 : 40,
          ),
        ),
        child: widget.isClicked
            ? AnimatedOpacity(
                opacity: _showContent ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 10,
                    children: [
                      const HuggleOrChannelBtn(
                        icon: Icons.headset_rounded,
                        title: 'Huggle',
                        subtitle: 'Start an audio or video chat',
                      ),
                      const HuggleOrChannelBtn(
                        icon: Icons.tag,
                        title: 'Channel',
                        subtitle: 'Create a new channel',
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF441045),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Icon(
                                Icons.edit_square,
                                color: Colors.white,
                              ),
                              Text(
                                'Message',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Out',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: Icon(Icons.edit_square, color: Colors.white),
              ),
      ),
    );
  }

  @override
  void didUpdateWidget(FloatActionButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isClicked == oldWidget.isClicked) {
      return;
    }
    if (widget.isClicked) {
      _showContentAfterAnimation();
    } else {
      if (_showContent) {
        _showContent = false;
      }
    }
  }
}
