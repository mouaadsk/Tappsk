import 'package:flutter/material.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Shared/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';
import 'package:intl/intl.dart';

class ReminderWidget extends StatefulWidget {
  SimpleTask simpleTask;
  ReminderWidget({Key key, @required this.simpleTask}) : super(key: key);
  @override
  _ReminderWidgetState createState() => _ReminderWidgetState();
}

class _ReminderWidgetState extends State<ReminderWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = getWidth(context),
        screenHeight = getHeight(context);
    return InkWell(
      onTap: () {
        showTimePicker(
          context: context,
          initialTime: this.widget.simpleTask.reminder != null
              ? this.widget.simpleTask.reminder
              : TimeOfDay.now(),
        ).then((choosedTime) {
          setState(() {
            this.widget.simpleTask.reminder = choosedTime;
          });
        });
      },
      child: Container(
        alignment: Alignment.centerLeft,
        height: screenWidth * .08,
        child: Row(
          children: [
            Icon(
              Icons.notifications,
              color: this.widget.simpleTask.reminder != null
                  ? Colors.blue
                  : Colors.grey[400],
              size: screenWidth * .08,
            ),
            SizedBox(width: screenWidth * .03),
            Text(
              this.widget.simpleTask.reminder != null
                  ? this.widget.simpleTask.reminder.format(context)
                  : "Add Reminder",
              style: TextStyle(
                color: this.widget.simpleTask.reminder != null
                    ? Colors.black
                    : Colors.grey[400],
                fontWeight: this.widget.simpleTask.reminder != null ? FontWeight.normal : FontWeight.w500,
                fontSize: screenWidth * .05,
              ),
            ),
            Expanded(child: SizedBox()),
            this.widget.simpleTask.reminder != null
                ? IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey[400],
                    ),
                    onPressed: () {
                      setState(() {
                        this.widget.simpleTask.reminder = null;
                      });
                    })
                : SizedBox(),
          ],
        ),
      ),
    );
    ;
  }
}
