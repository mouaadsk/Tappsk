import 'package:flutter/material.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Shared/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';

class RecurringTaskWidget extends StatefulWidget {
  SimpleTask simpleTask;
  RecurringTaskWidget({Key key, this.simpleTask}) : super(key: key);
  @override
  _RecurringTaskWidgetState createState() => _RecurringTaskWidgetState();
}

class _RecurringTaskWidgetState extends State<RecurringTaskWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = getWidth(context),
        screenHeight = getHeight(context);
    return InkWell(
      onTap: () {
        setState(() {
          this.widget.simpleTask.repeated = !this.widget.simpleTask.repeated;
        });
      },
      child: Container(
        height: screenHeight * .08,
        alignment: Alignment.centerLeft,
        child: Row(children: [
          Icon(
            Icons.refresh,
            color: this.widget.simpleTask.repeated != false
                ? Colors.blue
                : Colors.grey[400],
            size: screenWidth * .08,
          ),
          SizedBox(width: screenWidth * .03),
          Text(
            this.widget.simpleTask.repeated != false
                ? "Reccuring"
                : "Make Reccuring",
            style: TextStyle(
              color: this.widget.simpleTask.repeated != false
                  ? Colors.black
                  : Colors.grey[400],
              fontWeight:  this.widget.simpleTask.repeated != false ? FontWeight.normal : FontWeight.w500,
              fontSize: screenWidth * .05,
            ),
          ),
        ]),
      ),
    );
  }
}
