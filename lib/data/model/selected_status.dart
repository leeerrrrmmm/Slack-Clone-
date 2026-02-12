/// Selected status model /
class SelectedStatus {
  /// The emoji of the selected status. /
  final String? emoji;

  /// The title of the selected status. /
  final String? title;

  /// Constructor for the SelectedStatus model. /
  SelectedStatus({required this.emoji, required this.title});

  /// Parses Firestore status string "emoji title" into [SelectedStatus], or null if empty. /
  static SelectedStatus? fromStatusString(String? s) {
    if (s == null || s.trim().isEmpty) {
      return null;
    }
    final trimmed = s.trim();
    final i = trimmed.indexOf(' ');
    if (i <= 0) {
      return null;
    }

    return SelectedStatus(
      emoji: trimmed.substring(0, i),
      title: trimmed.substring(i + 1).trim(),
    );
  }
}
