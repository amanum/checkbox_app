import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CheckboxPainter extends CustomPainter {
  final double fraction;
  final Color color;
  CheckboxPainter(this.fraction, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(const Offset(15, 15), 15, Paint()..color = color);
    canvas.drawCircle(const Offset(15, 15), fraction, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CheckboxPainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}