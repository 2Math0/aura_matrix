import 'package:flutter/material.dart';

import 'dot_model.dart';

/// Painter for rendering dots on the canvas
class DotCanvas extends CustomPainter {
  final List<Dot> dots;
  final double dotSize;
  final Color dotColor;
  final Paint _paint;

  DotCanvas({required this.dots, required this.dotSize, required this.dotColor})
      : _paint = Paint()..color = dotColor;

  @override
  void paint(Canvas canvas, Size size) {
    for (var dot in dots) {
      canvas.drawCircle(Offset(dot.x, dot.y), dotSize / 2, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
