import 'package:checkbox_app/checkbox_painter.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final double fraction;
  final Color color;
  final double checkSize;

  const CustomCheckbox({
    required this.fraction,
    required this.color,
    required this.checkSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CheckboxPainter(fraction, color, checkSize),
      size: const Size(30, 30),
    );
  }
}
