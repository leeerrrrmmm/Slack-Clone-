import 'package:flutter/material.dart';

/// SearchFieldWidget is the widget that displays the search field.
class SearchFieldWidget extends StatelessWidget {
  /// Constructs a new SearchFieldWidget.
  const SearchFieldWidget({
    required this.searchController,
    super.key,
  });

  /// The controller for the search field.
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 20,
      ),

      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFDACFDA).withValues(alpha: 0.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Icon(
                Icons.search_rounded,
                color: Color(0xFFDACFDA),
                size: 35,
              ),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(
                    color: Color(0xFFDACFDA),
                  ),
                  controller: searchController,
                  cursorColor: const Color(0xFFDACFDA),
                  decoration: const InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: Color(0xFFDACFDA),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
