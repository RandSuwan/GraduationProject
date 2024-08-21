import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FingerDrawPainter extends CustomPainter {
  final List<Offset?> points;

  FingerDrawPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white  // Use a contrasting color to ensure visibility
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


