import 'package:flutter/material.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/task.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/sevices/arcCustomPainter.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  final double widgetSize;
  const TaskWidget({Key key, this.task, this.widgetSize}) : super(key: key);
  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  int oldSteps;
  double currentProgress;
  @override
  void initState() {
    super.initState();
    this.oldSteps = this.widget.task.completedSteps;
    this.currentProgress = this.widget.task.completedSteps.toDouble();
    this._animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {
              this.currentProgress =
                  this.oldSteps + this._animationController.value;
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed)
              setState(() {
                this.oldSteps = this.widget.task.completedSteps;
                this.currentProgress = this.oldSteps.toDouble();
              });
          });
  }

  bool stepForward() {
    try {
      this.widget.task.stepForward();
      this._animationController.forward().then((value) {
        if (!this.widget.task.isComplet) this._animationController.value = 0;
        print(this._animationController.isDismissed);
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(this.widget.widgetSize * .5),
      enableFeedback: false,
      onTap: () {
        if (!this.widget.task.isComplet) {
          print("circle is clicked");
          this.stepForward();
        }
      },
      child: Stack(alignment: Alignment.center, children: [
        SizedBox(
          width: this.widget.widgetSize,
          height: this.widget.widgetSize,
          child: CustomPaint(
            painter: ArcCustomPainter(
              percentage:
                  (this.currentProgress / this.widget.task.totalSteps) == 1
                      ? 0
                      : (this.currentProgress / this.widget.task.totalSteps),
              strokeWidth: this.widget.widgetSize / 37.5,
              strokeColor: this.widget.task.colors[0],
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: this.widget.task.isComplet && this._animationController.isCompleted
                  ? [Color(0xFFD1D1D1), Color(0xFFE7E7E7)]
                  : this.widget.task.colors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          width: this.widget.widgetSize * .9,
          height: this.widget.widgetSize * .9,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: this.widget.widgetSize * .1,
                child: Column(
                  children: [
                    Container(
                      child: Icon(
                        this.widget.task.icon,
                        color: Colors.white,
                        size: this.widget.widgetSize * .28,
                      ),
                    ),
                    SizedBox(height: this.widget.widgetSize * .05),
                    Text(
                      this.widget.task.completedSteps.toString() +
                          "/" +
                          this.widget.task.totalSteps.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: this.widget.widgetSize * .17),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
