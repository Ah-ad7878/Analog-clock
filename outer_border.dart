import 'dart:math';

import 'package:flutter/material.dart';

class Outerborder extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Size(:height, :width) = size;
    final radius = min(width, height) / 2;
    final center = Offset(width / 2, height / 2);

    final paint = Paint()
      ..color = const Color(0xFF1B1B1C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(Outerborder oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(Outerborder oldDelegate) => false;
}
