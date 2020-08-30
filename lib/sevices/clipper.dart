import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/emuns.dart';

class CircleBackgroundClipper extends CustomClipper<Path> {
  final double percentage;

  CircleBackgroundClipper(this.percentage);
  @override
  Path getClip(Size size) {
    Path cuttedPath = Path();
    double width = size.width, height = size.height, totalLengthToMove = 2 * (width * height) * this.percentage;
    cuttedPath.moveTo(size.width * .5, 0);
    SizeType movingLine = SizeType.Width;
    cuttedPath.moveTo(width, 0);
    cuttedPath.moveTo(0, height * .5);
    cuttedPath.moveTo(width * .5, height * .5);
    cuttedPath.moveTo(size.width * .5, 0);
    return cuttedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
