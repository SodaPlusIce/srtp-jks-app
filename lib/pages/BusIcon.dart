import 'package:flutter/material.dart';
import 'dart:math' as math;

class BusIcon extends StatelessWidget {
  final double size;
  final Color color;

  BusIcon({this.size = 24, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: BusIconPainter(color),
    );
  }
}

class BusIconPainter extends CustomPainter {
  final Color color;

  BusIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    // 绘制车身
    Path bodyPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.25)
      ..lineTo(size.width * 0.75, size.height * 0.25)
      ..lineTo(size.width * 0.75, size.height * 0.75)
      ..lineTo(size.width * 0.25, size.height * 0.75)
      ..close();
    canvas.drawPath(bodyPath, paint);

    // 绘制车轮
    paint.color = Colors.grey;
    canvas.drawCircle(
      Offset(size.width * 0.35, size.height * 0.75),
      size.width * 0.1,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.65, size.height * 0.75),
      size.width * 0.1,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
