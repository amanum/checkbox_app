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
      painter: CheckboxPainter(fraction, color),
      child: SizedBox(
        width: 30,
        height: 30,
        child: Icon(
          Icons.check,
          size: checkSize,
          color: Colors.white,
        ),
      ),
    );
  }
}
