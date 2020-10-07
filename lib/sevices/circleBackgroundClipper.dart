import 'package:flutter/material.dart';

class CircleBackgroundClipper extends CustomClipper<Path> {
  final double percentage;

  CircleBackgroundClipper(this.percentage);
  @override
  Path getClip(Size size) {
    Path cuttedPath = Path();
    double width = size.width, height = size.height, totalLengthToMove = 2 * (width * height) * this.percentage;
    cuttedPath.moveTo(size.width * .5, 0);
    cuttedPath.moveTo(width, 0);
    cuttedPath.moveTo(0, height * .5);
    cuttedPath.moveTo(width * .5, height * .5);
    cuttedPath.moveTo(size.width * .5, 0);
    return cuttedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
