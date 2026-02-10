import 'package:flutter/material.dart';
import 'package:slaac/view/dirrect/chat/widget/url_modal_sheet.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// ChatBubble is the widget that displays a single message in the chat.
class ChatBubble extends StatelessWidget {
  /// The message to display.
  final String message;

  /// Whether the message is from the current user.
  final bool isCurrentUser;

  /// The id of the message.
  final String messageId;

  /// The id of the user who sent the message.
  final String userId;

  /// Constructor for the ChatBubble widget.
  const ChatBubble({
    required this.message,
    required this.isCurrentUser,
    required this.messageId,
    required this.userId,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> links = [
      'google.com',
      'youtube.com',
      'facebook.com',
      'twitter.com',
      'instagram.com',
      'linkedin.com',
      'github.com',
      'stackoverflow.com',
      'reddit.com',
      'pinterest.com',
      'tiktok.com',
      'twitch.tv',
      'spotify.com',
      'apple.com',
      'microsoft.com',
      'amazon.com',
      'aliexpress.com',
    ];

    final bool isLink =
        message.startsWith('http://') ||
        message.startsWith('https://') ||
        links.contains(message);

    Uri normalizeUrl(String url) {
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        return Uri.parse('https://$url');
      }

      return Uri.parse(url);
    }

    //report message
    // void reportMessage(BuildContext context, String messageId, String userId) { */
    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       title: const Text('Report Message'),
    //       content: const Text('Are you sure you want to report this message?'), */
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //           child: const Text('Cancel'),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //             ScaffoldMessenger.of(
    //               context,
    //             ).showSnackBar(
    //               const SnackBar(content: Text('Message Reported')),
    //             );
    //           },
    //           child: const Text('Report'),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    //block user
    // void blockUser(BuildContext context, String userId) {
    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       title: const Text('Block User'),
    //       content: const Text('You sure you want to block this user?'),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //           child: const Text('Cancel'),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             ScaffoldMessenger.of(
    //               context,
    //             ).showSnackBar(const SnackBar(content: Text('User Blocked'))); */
    //           },
    //           child: const Text('Block'),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // show options
    // void showOptions(BuildContext context, String messageId, String userId) {
    //   showModalBottomSheet(
    //     context: context,
    //     builder: (context) {
    //       return SafeArea(
    //         child: Wrap(
    //           children: [
    //             //rep message button
    //             ListTile(
    //               leading: const Icon(Icons.flag),
    //               title: const Text('Report'),
    //               onTap: () {
    //                 //TODO: report message
    //                 // Navigator.pop(context);
    //                 // reportMessage(context, messageId, userId);
    //               },
    //             ),
    //             //block user button
    //             ListTile(
    //               leading: const Icon(Icons.block_rounded),
    //               title: const Text('Block'),
    //               onTap: () {
    //                 //TODO: block user
    //                 // Navigator.pop(context);
    //                 // blockUser(context, userId);
    //               },
    //             ),

    //cancel button
    //             ListTile(
    //               leading: const Icon(Icons.cancel_sharp),
    //               title: const Text('Canсel'),
    //               onTap: () {
    //                 Navigator.pop(context);
    //               },
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   );
    // }

    return GestureDetector(
      onLongPress: () {
        if (!isCurrentUser) {
          return;
        } else {
          //TODO: show options
        }
      },
      child: GestureDetector(
        onTap: () {
          if (!isLink) return;

          final wViewController = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(normalizeUrl(message));

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => UrlModalSheet(
              isLink: isLink,
              links: links,
              controller: wViewController,
              message: message,
            ),
          );
        },

        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            color: isCurrentUser ? const Color(0xFF441045) : Colors.grey[200],
            borderRadius: isCurrentUser
                ? const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(4),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(4),
                  ),
          ),
          child: Text(
            message,
            style: TextStyle(
              fontSize: 15,
              color:
                  links.contains(message) ||
                      message.startsWith('http://') ||
                      message.startsWith('https://')
                  ? Colors.blue
                  : isCurrentUser
                  ? Colors.white
                  : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
