import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/subtask.dart';
import 'package:intl/intl.dart';

class SimpleTask {
  String title, note;
  DateTime finishingDate;
  TimeOfDay reminder;
  Color boxColor;
  bool repeated, completed = false;
  int makeBigger = 0;
  List<SubTask> subtasks;
  TextEditingController titleEditingController, noteEditingController;
  SimpleTask(
      {this.title,
      this.subtasks,
      this.boxColor = Colors.amber,
      this.finishingDate,
      this.repeated = false}) {
    this.titleEditingController = TextEditingController(text: this.title);
    this.noteEditingController = TextEditingController(text: this.note);
  }

  String getFormattedDateTime() {
    var formatter = DateFormat.jm();
    return formatter.format(this.finishingDate);
  }

  String todayOrTomorrow() {
    Duration difference = this.finishingDate.difference(DateTime.now());
    if (difference.inDays == 0)
      return "Today";
    else if (difference.inDays == 1)
      return "Tomorrow";
    else
      return DateFormat("EEEE").format(this.finishingDate);
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
