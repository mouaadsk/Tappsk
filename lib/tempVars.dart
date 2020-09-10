import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/circletask.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:humanitarian_icons/humanitarian_icons.dart';

List<CircleTask> tempTasks = [
  CircleTask(
    5,
    0,
    FontAwesomeIcons.tint,
    [Color(0xFF045DE9), Color(0xFF09C6F9)],
    "Drink Water"
  ),
  CircleTask(
    2,
    1,
    FontAwesome.apple,
    [Color(0xFF00AB08), Color(0xFF95F985)],
    "Eat Fruit"
  ),
  CircleTask(
    3,
    2,
    FontAwesomeIcons.pills,
    [Color(0xFFDC1C13), Color(0xFFF07470)],
    "Take Pill"
  ),
  CircleTask(
    1,
    0,
    FontAwesomeIcons.book,
    [Color(0xFFFA8607), Color(0xFFFCB033)],
    "Read Book"
  ),
  
];
