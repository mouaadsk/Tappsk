import 'package:flutter/material.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Shared/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/sevices/rectPercentageClipper.dart';

class TaskTile extends StatefulWidget {
  final SimpleTask simpleTask;
  const TaskTile({Key key, @required this.simpleTask}) : super(key: key);
  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool coloringBox = false;
  //TODO : turning the task into a finished task then running the animation like it vanishes
  bool finishTask() {
    try {
      this._animationController.forward().then((value) {
        this.widget.simpleTask.completeTask();
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //! returning the top widget of the tile
  Widget returnTopWidget(BuildContext context) {
    final screenWidth = getWidth(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              this.coloringBox = true;
              this.finishTask();
            });
          },
          child: Container(
            width: screenWidth * .06,
            height: screenWidth * .06,
            decoration: BoxDecoration(
              color: this.coloringBox
                  ? this.widget.simpleTask.boxColor
                  : Colors.transparent,
              border: Border.all(
                width: screenWidth * .008,
                color: this.widget.simpleTask.boxColor,
              ),
              borderRadius:
                  BorderRadius.all(Radius.circular(screenWidth * .02)),
            ),
            alignment: Alignment.center,
            child: this.coloringBox
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
          this.widget.simpleTask.title,
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
    this._animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = getWidth(context),
        screenHeight = getHeight(context);
    return this.widget.simpleTask != null
        ? ClipPath(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            clipper: RectHeightPercentageClipper(
                percentage: this._animationController.value),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius:
                    BorderRadius.all(Radius.circular(screenWidth * .02)),
              ),
              padding: EdgeInsets.all(screenWidth * .03),
              width: screenWidth * .9,
              height:
                  screenHeight * .08 * (1 - this._animationController.value),
              child: this.widget.simpleTask.finishDateTime == null
                  ? SingleChildScrollView(
                      child: Material(
                          type: MaterialType.transparency,
                          child: returnTopWidget(context)),
                    )
                  : SingleChildScrollView(
                      child: Material(
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
                                      this
                                          .widget
                                          .simpleTask
                                          .getFormattedDateTime(),
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
                    ),
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
