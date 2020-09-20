import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/colorBool.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';

class ListSimpleTasksModel {
  String title;
  List<SimpleTask> listSimpleTasks;
  List<Widget> listOfDraggables = List<Widget>();
  int firstInt = 0, lastInt = 0;
  ListSimpleTasksModel({
    @required this.listSimpleTasks,
    @required this.title,
  }) : assert(listSimpleTasks != null, title != null);
  //TODO : we need to change the ColorBool with SimpleTask class
  bool addeElementIndex(int index, SimpleTask simpleTask) {
    try {this.listSimpleTasks.insert(index, simpleTask);
    return true;}
    catch(e){
      print(e.toString());
      return false;
    }
  }

  bool deleteElementIndex(int index) {
    this.listSimpleTasks.removeAt(index);
    return true;
  }

  bool reset() {
    this.listSimpleTasks.forEach((element) {
      element.reset();
     });
     this.firstInt = 0;
     this.lastInt = 0;
     return true;
  }
}
