import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Shared/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';
import 'package:intl/intl.dart';

class DateTimePickerWidget extends StatefulWidget {
  SimpleTask simpleTask;
  DateTimePickerWidget({
    Key key,
    @required this.simpleTask,
  }) : super(key: key);
  @override
  _DateTimePickerWidgetState createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = getHeight(context),
        screenWidth = getWidth(context);
    return InkWell(
      onTap: () {
        showDatePicker(
            context: context,
            initialDate: this.widget.simpleTask.finishingDate != null
                ? this.widget.simpleTask.finishingDate
                : DateTime.now(),
            firstDate: DateTime.now().subtract(
              Duration(
                days: 1,
              ),
            ),
            lastDate: DateTime.now().add(
              Duration(
                days: 365 * 5,
              ),
            )).then((choosedDate) {
          setState(() {
            this.widget.simpleTask.finishingDate = choosedDate;
          });
        });
      },
      child: Container(
        alignment: Alignment.centerLeft,
        height: screenWidth * .08,
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: this.widget.simpleTask.finishingDate != null
                  ? Colors.blue
                  : Colors.grey[400],
              size: screenWidth * .07,
            ),
            SizedBox(width: screenWidth * .04),
            Text(
              this.widget.simpleTask.finishingDate != null
                  ? (DateFormat("MMMM d, ").format(
                        this.widget.simpleTask.finishingDate,
                      ) +
                      this.widget.simpleTask.todayOrTomorrow())
                  : "Add Task Date",
              style: TextStyle(
                color: this.widget.simpleTask.finishingDate != null
                    ? Colors.black
                    : Colors.grey[400],
                fontWeight: this.widget.simpleTask.finishingDate != null
                    ? FontWeight.normal
                    : FontWeight.w500,
                fontSize: screenWidth * .05,
              ),
            ),
            Expanded(child: SizedBox()),
            this.widget.simpleTask.finishingDate != null
                ? IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey[400],
                      size: screenWidth * .05,
                    ),
                    onPressed: () {
                      setState(() {
                        this.widget.simpleTask.finishingDate = null;
                      });
                    })
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
