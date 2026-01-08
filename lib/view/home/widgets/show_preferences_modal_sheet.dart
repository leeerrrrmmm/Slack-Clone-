import 'package:flutter/material.dart';
import 'package:slaac/view/home/widgets/preferences_all_widget_info.dart';

///
class ShowPreferencesModalSheet extends StatelessWidget {
  /// Constructs a new ShowPreferencesModalSheet.
  const ShowPreferencesModalSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                spacing: 90,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(
                        Icons.close,
                        size: 30,
                      ),
                    ),
                  ),
                  const Text(
                    'Preferences',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Out',
                    ),
                  ),
                ],
              ),

              ///Preferences
              const PreferencesAllWidgetInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
