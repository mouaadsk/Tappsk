import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Shared/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/subtask.dart';

class SubTaskWidget extends StatefulWidget {
  final SubTask subTask;
  const SubTaskWidget({Key key, this.subTask}) : super(key: key);
  @override
  _SubTaskWidgetState createState() => _SubTaskWidgetState();
}

class _SubTaskWidgetState extends State<SubTaskWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = getHeight(context),
        screenWidth = getWidth(context);
    return Row(
      children: [
        Container(
          height: screenWidth * .05,
          width: screenWidth * .05,
          decoration: BoxDecoration(
            border: Border.all(
              color: this.widget.subTask.circleColor,
              width: screenWidth * .007,
            ),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: screenWidth * .05),
        Text(
          this.widget.subTask.title,
          style: GoogleFonts.rubik(
            fontWeight: FontWeight.normal,
            fontSize: screenHeight * .02,
            color: Colors.black,
          ),
        ),
        Expanded(child: SizedBox(),),
        IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              print("Hamburger menu is clicked");
            })
      ],
    );
  }
}
