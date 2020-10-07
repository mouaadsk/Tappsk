import 'package:flutter/material.dart';



double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      MediaQuery.of(context).padding.bottom;
}

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width -
      MediaQuery.of(context).padding.left -
      MediaQuery.of(context).padding.right;
}

