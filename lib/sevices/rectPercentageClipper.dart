import 'package:flutter/material.dart';

class RectHeightPercentageClipper extends CustomClipper<Path> {
  final double percentage;

  RectHeightPercentageClipper({this.percentage});

  @override
  Path getClip(Size size) {
    Path rect = Path();
    rect.moveTo(0, size.height);
    rect.lineTo(size.width, size.height);
    rect.lineTo(size.width, this.percentage* size.height);
    rect.lineTo(0, this.percentage* size.height);
    rect.lineTo(0, size.height);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
