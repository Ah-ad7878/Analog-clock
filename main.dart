import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_black_shade_clock_painter/clock_painter.dart';
import 'package:flutter_black_shade_clock_painter/outer_border.dart';

void main() {
  runApp(TopNameBar());
}

class TopNameBar extends StatelessWidget {
  const TopNameBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Black color clock',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _datetime = DateTime.now();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _datetime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double outerClockSize = 250;
    final double innerClockSize = 245;
    return Scaffold(
      backgroundColor: Color(0xFF2B2B2B),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: outerClockSize,
              height: outerClockSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2B2B2B),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    blurRadius: 15,
                    offset: const Offset(8, 8),
                  ),
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(-8, -8),
                  ),
                ],
              ),
            ),

            Container(
              width: innerClockSize,
              height: innerClockSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF222222),
              ),
            ),

            SizedBox(
              width: innerClockSize,
              height: innerClockSize,
              child: CustomPaint(painter: Clockpainter(dateTime: _datetime)),
            ),

            SizedBox(
              width: outerClockSize,
              height: outerClockSize,
              child: CustomPaint(painter: Outerborder()),
            ),
          ],
        ),
      ),
    );
  }
}
