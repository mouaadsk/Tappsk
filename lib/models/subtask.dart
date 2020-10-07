import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubTask {
  String title;
  TextEditingController titleEditingController;
  Color circleColor;
  bool subTaskIsFinished;
  SubTask({
    this.title,
    this.circleColor = Colors.amber,
  }) {
    this.titleEditingController = TextEditingController(
      text: this.title,
    );
    this.subTaskIsFinished = false;
  }
}
