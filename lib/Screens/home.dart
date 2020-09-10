import 'package:flutter/material.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/circleTasksList.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/taskTile.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/tasksTileList.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/generaleFunctions.dart';
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
  List<ColorBool> listSimpleTasks = [
    ColorBool(color: Colors.amber),
    ColorBool(color: Colors.black),
    ColorBool(color: Colors.red),
    ColorBool(color: Colors.blue),
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
          child: Stack(
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
