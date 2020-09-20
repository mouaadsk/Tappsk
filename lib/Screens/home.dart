import 'package:flutter/material.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/tasksTileList.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/circletask.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/colorBool.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/listSimpleTasksModel.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/tempVars.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CircleTask tempTask = tempTasks[3];
  List<SimpleTask> listSimpleTasks = [
    SimpleTask(
      boxColor: Colors.amber,
      description: "Eating dinner",
      finishDateTime: DateTime.now(),
    ),
    SimpleTask(
      boxColor: Colors.black,
      description: "Reading a book",
      finishDateTime: DateTime.now().add(Duration(days: 1)),
    ),
    SimpleTask(
      boxColor: Colors.red,
      description: "Workout",
      finishDateTime: DateTime.now().add(Duration(days: 7)),
    ),
    SimpleTask(
      boxColor: Colors.blue,
      description: "Drinking Water",
      repeated: true,
    ),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          // CircleTasksList(
          //   height: screenWidth * .3,
          //   listTasks: tempTasks,
          // ),
          TaskTileList(
            listSimpleTasksModel: ListSimpleTasksModel(
                listSimpleTasks: this.listSimpleTasks, title: "Today"),
          ),
        ],
      )),
    );
  }
}
