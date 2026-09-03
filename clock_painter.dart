import 'dart:math';

import 'package:flutter/material.dart';

class Clockpainter extends CustomPainter {
  Clockpainter({required this._dateTime});
  final DateTime _dateTime;
  @override
  void paint(Canvas canvas, Size size) {
    //calculate value here
    final Size(:height, :width) = size;
    final radius = min(width, height) / 2;
    final center = Offset(width / 2, height / 2);

    //calculate angle for rotation of canvas
    final angle = pi * 2 / 60;

    //hours and mintes lines
    final hoursWidth = radius * 0.03;
    final hoursHeight = radius * 0.15;
    final mintWidth = radius * 0.02;
    final mintHeight = radius * 0.06;
    final hoursNeedleBaseRadius = radius * 0.057;
    final mintNeedelBaseRadius = radius * 0.040;

    //Create hours needles
    final hourNeedleStart = Offset(0, 0);
    final hourNeedleEnd = Offset(0, -radius * 0.51);
    final hourAngle = (_dateTime.hour % 12 + _dateTime.minute / 60) * (pi / 6);

    final mintNeedleStart = Offset(0, 0);
    final mintNeedleEnd = Offset(0, -radius * 0.75);
    final minuteAngle = (_dateTime.minute + _dateTime.second / 60) * (pi / 30);
    final secondAngle = _dateTime.second * (pi / 30);

    //create paint here
    final hoursStickColor = Paint()
      ..color = Colors.green
      ..strokeWidth = hoursWidth;

    final mintStickColor = Paint()
      ..color = Colors.white
      ..strokeWidth = mintWidth;

    final hourNeedleColor = Paint()
      ..color = Color(0xFF5394ED)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    final mintNeedleColor = Paint()
      ..color = Color.fromARGB(255, 107, 154, 221)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    final mintNeedleBaseColor = Paint()
      ..color = Colors.grey.shade300
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    final secondNeedleColor = Paint()
      ..color = Colors.redAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    //Draw clock here
    canvas.drawCircle(center, hoursNeedleBaseRadius, hourNeedleColor);
    canvas.drawCircle(center, mintNeedelBaseRadius, mintNeedleBaseColor);
    canvas.translate(center.dx, center.dy);
    canvas.save();
    for (var i = 1; i <= 60; i++) {
      canvas.rotate(angle);

      //print hours and mint stick
      var isHours = i % 5 == 0;
      if (isHours) {
        canvas.drawLine(
          Offset(0, -radius),
          Offset(0, -(radius - hoursHeight)),
          hoursStickColor,
        );
      } else {
        canvas.drawLine(
          Offset(0, -radius),
          Offset(0, -(radius - mintHeight)),
          mintStickColor,
        );
      }
    }
    canvas.restore();

    canvas.save();
    canvas.rotate(hourAngle);
    canvas.drawLine(hourNeedleStart, hourNeedleEnd, hourNeedleColor);
    canvas.restore();

    canvas.save();
    canvas.rotate(minuteAngle);
    canvas.drawLine(mintNeedleStart, mintNeedleEnd, mintNeedleColor);
    canvas.restore();

    canvas.save();
    canvas.rotate(secondAngle);
    canvas.drawLine(
      Offset(0, radius * 0.10),
      Offset(0, -radius * 0.79),
      secondNeedleColor,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(Clockpainter oldDelegate) =>
      oldDelegate._dateTime != _dateTime;

  @override
  bool shouldRebuildSemantics(Clockpainter oldDelegate) =>
      oldDelegate._dateTime != _dateTime;
}
