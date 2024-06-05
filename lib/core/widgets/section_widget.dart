import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.headerTitle,
    this.headerTrailing,
    required this.child,
  });

  final String headerTitle;
  final Widget? headerTrailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                headerTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              if (headerTrailing != null) headerTrailing!,
            ],
          ),
        ),
        const SizedBox(height: 10),
        child
      ],
    );
  }
}
