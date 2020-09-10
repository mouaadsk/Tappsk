import 'package:flutter/material.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class TaskTile extends StatefulWidget {
  final SimpleTask simpleTask;
  const TaskTile({Key key, @required this.simpleTask}) : super(key: key);
  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  //! returning the top widget of the tile
  Widget returnTopWidget(BuildContext context) {
    final screenWidth = getWidth(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: screenWidth * .06,
          height: screenWidth * .06,
          decoration: BoxDecoration(
            border: Border.all(
              width: screenWidth * .008,
              color: this.widget.simpleTask.boxColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(screenWidth * .02)),
          ),
        ),
        SizedBox(
          width: screenWidth * .02,
        ),
        Text(
          this.widget.simpleTask.description,
          style: GoogleFonts.rubik(
            fontSize: screenWidth * .055,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(
          width: screenWidth * .01,
        ),
        this.widget.simpleTask.repeated
            ? Icon(
                EvaIcons.refresh,
                size: screenWidth * .05,
                color: Colors.grey,
              )
            : SizedBox(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = getWidth(context),
        screenHeight = getHeight(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(screenWidth * .02)),
      ),
      padding: EdgeInsets.all(screenWidth * .03),
      width: screenWidth * .9,
      height: screenHeight * .1,
      child: this.widget.simpleTask.finishDateTime == null
          ? returnTopWidget(context)
          : Column(children: [
              returnTopWidget(context),
              Container(
                margin: EdgeInsets.only(left: screenWidth * .1),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.bell,
                      color: Colors.grey,
                      size: screenWidth * .04,
                    ),
                    SizedBox(width: screenWidth * .01),
                    Text(
                      this.widget.simpleTask.todayOrTomorrow() +
                          " " +
                          this.widget.simpleTask.getFormattedDateTime(),
                      style: GoogleFonts.rubik(
                          fontSize: screenWidth * .04,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ]),
    );
  }
}
