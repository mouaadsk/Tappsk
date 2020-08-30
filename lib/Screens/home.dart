import 'package:flutter/material.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/taskWidget.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/task.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/sevices/arcCustomPainter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Task tempTask = Task(
    5,
    0,
    FontAwesomeIcons.tint,
    [Color(0xFF045DE9), Color(0xFF09C6F9)],
  );
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
    final double screenWidth = getWidth(context),
        screenHeight = getHeight(context);
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Center(
            child: TaskWidget(
              task: this.tempTask,
              widgetSize: screenWidth * .3,
            ),
          ),
        ],
      )),
    );
  }
}
