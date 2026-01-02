import 'package:flutter/material.dart';

/// NextYouCould is the widget that displays the next you could widget.
class NextYouCould extends StatelessWidget {
  /// Title of the next you could widget. Required.
  final String title;

  /// Icon of the next you could widget. Required.
  final String imageAsset;

  /// Description of the next you could widget. Required.
  final String description;

  /// Constructs a new NextYouCould.
  const NextYouCould({
    required this.title,
    required this.imageAsset,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Row(
        spacing: 10.0,
        children: [
          Image.asset(imageAsset),
          Column(
            spacing: 10.0,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
