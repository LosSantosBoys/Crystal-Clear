import 'package:flutter/material.dart';

/// Generates a random color based on the provided seed.
///
/// The [seed] parameter is an optional string used to generate a unique color.
/// If no seed is provided, a random color will be generated.
/// The generated color will be darkened if its luminance is less than 0.5.
/// 
/// This method is computationally expensive to calculate, therefore it is not
/// recommended to use it in performance-critical scenarios. It is best used for
/// generating colors for UI elements that do not require frequent updates, like
/// user avatar or placeholders.
///
/// Returns a [Color] object representing the generated color.
/// 
/// Example usage:
/// ```dart
/// Color color = generateRandomColor(seed: "example");
/// ```
Color generateRandomColor({String? seed}) {
  Color? color;

  if (seed != null) {
    final int hash = seed.hashCode;

    final int r = (hash & 0xFF0000) >> 16;
    final int g = (hash & 0x00FF00) >> 8;
    final int b = hash & 0x0000FF;
    const double opacity = 1.0;

    color = Color.fromRGBO(r, g, b, opacity);
  } else {
    color = Color((DateTime.now().millisecondsSinceEpoch / 10).floor() % 0xFFFFFFFF);
  }

  if (color.computeLuminance() <= 0.5) {
    color = darken(color, 0.12);
  }

  return color;
}

/// Darkens the given [color] by the specified [amount].
///
/// The [amount] parameter should be a value between 0 and 1, where 0 represents
/// no darkening and 1 represents maximum darkening. Values outside this range
/// will be clamped to the nearest valid value.
///
/// This function uses the HSL color model to darken the color. It converts the
/// given [color] to HSL, adjusts the lightness component by subtracting the
/// [amount], and then converts the modified HSL color back to RGB.
///
/// Example usage:
/// ```dart
/// Color darkenedColor = darken(Colors.blue, 0.2);
/// ```
Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

/// Lightens the given [color] by the specified [amount].
///
/// The [amount] parameter should be a value between 0 and 1, where 0 represents
/// no lighting and 1 represents maximum lighting. Values outside this range
/// will be clamped to the nearest valid value.
///
/// This function uses the HSL color model to lighten the color. It converts the
/// given [color] to HSL, adjusts the lightness component by adding the
/// [amount], and then converts the modified HSL color back to RGB.
///
/// Example usage:
/// ```dart
/// Color lightnedColor = lighten(Colors.blue, 0.2);
/// ```
Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}

extension StringExtension on String {
  /// Capitalizes the first letter of a string.
  ///
  /// Returns a new string with the first letter capitalized and the rest of the string unchanged.
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension UserExtension on String {
  /// Extracts the username from a string that follows the format of an email address.
  /// 
  /// Returns the username portion of the string.
  String toUsername() {
    return split('@').first;
  }
}

extension SnackbarExtension on BuildContext {
  void showErrorSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            const SizedBox(width: 10),
            Text(message),
          ],
        ),
      ),
    );
  }

  void showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            const SizedBox(width: 10),
            Text(message),
          ],
        ),
      ),
    );
  }

  void showInfoSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.info_outline,
              color: Colors.blue,
            ),
            const SizedBox(width: 10),
            Text(message),
          ],
        ),
      ),
    );
  }

  void showWarningSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.warning_amber_outlined,
              color: Colors.orange,
            ),
            const SizedBox(width: 10),
            Text(message),
          ],
        ),
      ),
    );
  }
}
