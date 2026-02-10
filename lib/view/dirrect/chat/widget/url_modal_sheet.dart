import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

///UrlModalSheet is the widget that displays the modal sheet for the link.
class UrlModalSheet extends StatefulWidget {
  ///Constructor for the UrlModalSheet widget.
  const UrlModalSheet({
    required this.message,
    required this.isLink,
    required this.links,
    required this.controller,
    super.key,
  });

  ///The message to display.
  final String message;

  ///Whether the message is a link.
  final bool isLink;

  ///The list of links to display.
  final List<String> links;

  ///The controller for the web view.
  final WebViewController controller;

  @override
  State<UrlModalSheet> createState() => _UrlModalSheetState();
}

class _UrlModalSheetState extends State<UrlModalSheet> {
  double scrollProgress = 0.0;

  static const String _scrollListenerJS = '''
  (function () {
    function sendScrollProgress() {
      const scrollTop = window.scrollY || document.documentElement.scrollTop;
      const docHeight = document.documentElement.scrollHeight;
      const winHeight = window.innerHeight;
      const progress = docHeight > winHeight
        ? scrollTop / (docHeight - winHeight)
        : 1;
      ScrollProgress.postMessage(progress.toString());
    }
    window.addEventListener('scroll', sendScrollProgress);
    sendScrollProgress();
  })();
  ''';

  @override
  void initState() {
    super.initState();
    widget.controller
      ..addJavaScriptChannel(
        'ScrollProgress',
        onMessageReceived: (message) {
          final value = double.tryParse(message.message) ?? 0.0;
          setState(() {
            scrollProgress = value.clamp(0.0, 1.0);
          });
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            widget.controller.runJavaScript(_scrollListenerJS);
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          ///Top info about the link
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Exit Button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF441045),
                    ),
                    child: const Center(
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                ),

                ///Link Info
                SizedBox(
                  width: 250,
                  height: 45,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF441045),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: scrollProgress,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          widget.message,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                ///Action Button
                GestureDetector(
                  onTap: () {
                    //TODO: Show Actions
                    log('Show Actions');
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF441045),
                    ),
                    child: const Center(
                      child: Icon(Icons.more_vert, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (!widget.isLink && !widget.links.contains(widget.message))
            const Text('Error hande this link')
          else
            Expanded(
              child: WebViewWidget(
                controller: widget.controller,
                gestureRecognizers: const {
                  Factory<OneSequenceGestureRecognizer>(
                    EagerGestureRecognizer.new,
                  ),
                },
              ),
            ),
        ],
      ),
    );
  }
}
