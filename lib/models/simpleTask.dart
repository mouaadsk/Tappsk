import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/subtask.dart';

class SimpleTask {
  String title, note;
  DateTime finishDateTime;
  Color boxColor;
  bool repeated, completed = false;
  int makeBigger = 0;
  List<SubTask> subtasks;
  TextEditingController titleEditingController, noteEditingController;
  SimpleTask(
      {@required this.title,
      @required this.subtasks,
      this.boxColor = Colors.amber,
      this.finishDateTime,
      this.repeated = false}) {
    assert(title != null);
    this.titleEditingController = TextEditingController(text: this.title);
    this.noteEditingController = TextEditingController(text: this.note);
  }

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

  bool reset() {
    this.makeBigger = 0;
    return true;
  }

  bool completeTask() {
    this.completed = true;
    return this.completed;
  }
}
