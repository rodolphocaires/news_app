import 'package:flutter/material.dart';

class PaddingWithText extends StatelessWidget {
  const PaddingWithText({
    super.key,
    required this.text,
    required this.fontSize,
    this.textPrefix = '',
  });

  final String text;
  final String textPrefix;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
      child: Text(
        textPrefix.isNotEmpty ? '$textPrefix $text' : text,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
}
