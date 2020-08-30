import 'package:flutter/material.dart';

import 'dart:math';

class ArcCustomPainter extends CustomPainter {
  final double percentage, strokeWidth;
  final Color strokeColor;
  ArcCustomPainter({this.strokeColor,this.percentage, this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width, height = size.height, endingPoint = (2 * pi) * this.percentage;
    Rect rect = Rect.fromLTWH(0.0, 0.0, width, height);
    //! this is the first by Using drawing the arc from a Path
    // Path path = Path()..arcTo(rect, 0.0 , -pi / 2, true);
    // canvas.drawPath(path, Paint()..color = Colors.orange..strokeWidth = this.strokeWidth..style = PaintingStyle.stroke);
    //! this is the second method by drawing directly the Arc
    canvas.drawArc(rect, -pi * .5, endingPoint , false, Paint()..color = this.strokeColor..strokeWidth = this.strokeWidth..style= PaintingStyle.stroke);
    canvas.drawArc(rect, (-pi * .5) + endingPoint, (2 * pi) - endingPoint, false, Paint()..color = Colors.grey[200]..strokeWidth = this.strokeWidth..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
