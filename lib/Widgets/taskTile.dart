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
        InkWell(
          onTap: (){
            setState(() {
              this.widget.simpleTask.completeTask();
            });
          },
          child: Container(
            width: screenWidth * .06,
            height: screenWidth * .06,
            decoration: BoxDecoration(
              color: this.widget.simpleTask.completed ? this.widget.simpleTask.boxColor : Colors.transparent,
              border: Border.all(
                width: screenWidth * .008,
                color: this.widget.simpleTask.boxColor,
              ),
              borderRadius:
                  BorderRadius.all(Radius.circular(screenWidth * .02)),
            ),
            alignment: Alignment.center,
            child: this.widget.simpleTask.completed
                ? Icon(
                    Icons.check,
                    color: Colors.white,
                    size: screenWidth * .04,
                  )
                : Container(
                    width: 0,
                    height: 0,
                  ),
          ),
        ),
        SizedBox(
          width: screenWidth * .02,
        ),
        Text(
          this.widget.simpleTask.description,
          style: GoogleFonts.rubik(
            fontSize: screenWidth * .04,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(
          width: screenWidth * .01,
        ),
        this.widget.simpleTask.repeated
            ? Icon(
                EvaIcons.refresh,
                size: screenWidth * .045,
                color: Colors.grey,
              )
            : SizedBox(),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (this.widget.simpleTask == null) {
      print("the simple task is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = getWidth(context),
        screenHeight = getHeight(context);
    return this.widget.simpleTask != null
        ? Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius:
                  BorderRadius.all(Radius.circular(screenWidth * .02)),
            ),
            padding: EdgeInsets.all(screenWidth * .03),
            width: screenWidth * .9,
            height: screenHeight * .08,
            child: this.widget.simpleTask.finishDateTime == null
                ? Material(
                    type: MaterialType.transparency,
                    child: returnTopWidget(context))
                : Material(
                    type: MaterialType.transparency,
                    child: Column(children: [
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
                                  fontSize: screenWidth * .03,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
          )
        : Container(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent.withOpacity(0.2),
              borderRadius:
                  BorderRadius.all(Radius.circular(screenWidth * .02)),
            ),
            padding: EdgeInsets.all(screenWidth * .03),
            width: screenWidth * .9,
            height: screenHeight * .08,
          );
  }
}
