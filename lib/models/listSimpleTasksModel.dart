import 'package:flutter/foundation.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/colorBool.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';

class ListSimpleTasksModel {
  String title;
  List<ColorBool> listSimpleTasks;
  ListSimpleTasksModel({
    @required this.listSimpleTasks,
    @required this.title,
  }) : assert(listSimpleTasks != null, title != null);
  //TODO : we need to change the ColorBool with SimpleTask class
  bool addeElementIndex(int index, ColorBool simpleTask) {
    this.listSimpleTasks.insert(index, simpleTask);
    return true;
  }

  bool deleteElementIndex(int index) {
    this.listSimpleTasks.removeAt(index);
    return true;
  }
}
