import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SimpleTask {
  String description;
  DateTime finishDateTime;
  Color boxColor;
  bool repeated;
  int makeBigger = 0;
  SimpleTask(
      {@required this.description,
      this.boxColor = Colors.amber,
      this.finishDateTime,
      this.repeated = false})
      : assert(description != null);

  String getFormattedDateTime() {
    var formatter = DateFormat.jm();
    return formatter.format(this.finishDateTime);
  }

  String todayOrTomorrow() {
    if (this.finishDateTime.day == DateTime.now().day)
      return "Today";
    else
      return "Tomorrow";
  }
  bool reset(){
    this.makeBigger = 0;
    return true;
  }
}
