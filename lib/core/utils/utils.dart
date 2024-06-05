extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension UserExtension on String {
  String toUsername() {
    return split('@').first;
  }
}
