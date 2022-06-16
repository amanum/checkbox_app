import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CheckboxPainter extends CustomPainter {
  final double fraction;
  final Color color;
  final double checkSize;
  CheckboxPainter(this.fraction, this.color, this.checkSize);

  @override
  void paint(Canvas canvas, Size size) {
    const icon = Icons.check;
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      fontFamily: icon.fontFamily,
      fontSize: checkSize,
      fontWeight: FontWeight.bold,
    ))
      ..pushStyle(ui.TextStyle(color: Colors.white))
      ..addText(String.fromCharCode(icon.codePoint));
    var para = builder.build();
    para.layout(const ui.ParagraphConstraints(width: 60));
    canvas.drawCircle(const Offset(15, 15), 15, Paint()..color = color);
    canvas.drawCircle(const Offset(15, 15), fraction, Paint()..color = Colors.white);
    canvas.drawParagraph(para, getIconOffset(checkSize));
  }

  Offset getIconOffset(double iconSize) {
    final offset = 15 - (0.5 * iconSize);
    return Offset(offset, offset);
  }

  @override
  bool shouldRepaint(covariant CheckboxPainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}