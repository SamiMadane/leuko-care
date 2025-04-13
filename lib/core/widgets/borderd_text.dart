import 'package:flutter/material.dart';

class BorderedText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color borderColor;
  final double strokeWidth;

  const BorderedText({
    super.key,
    required this.text,
    required this.style,
    this.borderColor = Colors.black,
    this.strokeWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // النص بالبورد
        Text(
          text,
          style: style.copyWith(
            foreground:
                Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = strokeWidth
                  ..color = borderColor,
          ),
        ),

        // النص بلونه العادي
        Text(text, style: style),
      ],
    );
  }
}
