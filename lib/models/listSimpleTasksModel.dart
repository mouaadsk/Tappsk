import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  bool addeElementIndex(int index, SimpleTask simpleTask) {
    try {
      this.listSimpleTasks.insert(index, simpleTask);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  bool deleteElementIndex(int index) {
    this.listSimpleTasks.removeAt(index);
    return true;
  }

  //!this function deletes the finished tasks and resetes all the paramaters of the list into a zeros
  bool reset() {
    this.listSimpleTasks.asMap().forEach((index, element) {
      if (!element.completed)
        element.reset();
      else
        this.deleteElementIndex(index);
    });
    this.firstInt = 0;
    this.lastInt = 0;
    return true;
  }
}
