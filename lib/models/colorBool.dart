import 'package:flutter/material.dart';

class ColorBool {
  Color color;
  int makeBigger;
  ColorBool({@required this.color, this.makeBigger = 0});


  bool reset(){
    this.makeBigger = 0;
    return true;
  }
}
