import 'package:flutter/material.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Shared/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/circletask.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/circleTaskWidget.dart';

class CircleTasksList extends StatefulWidget {
  List<CircleTask> listTasks;
  final double height;
  CircleTasksList({Key key, @required this.listTasks, this.height})
      : super(key: key);
  @override
  _CircleTasksListState createState() => _CircleTasksListState();
}

class _CircleTasksListState extends State<CircleTasksList>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Widget _theLeftPart, _theRightPart, _theFinishedElement, _theNextElement;
  int finishedIndex;

  //! P.S : I am passing this funtion to the CircleWidget, so it is called whenever a taskCircle is finished
  bool startAnimation(int indexOfFinished) {
    try {
      this.finishedIndex = indexOfFinished;
      //TODO1 : finding the index of the clicked element
      print("the index of finished element is : " + indexOfFinished.toString());

      //TODO2 : Turn the finished widget into an element of the stack
      this._theFinishedElement = Container(
        height: this.widget.height * 1.23,
        width: this.widget.height * .86,
        padding: EdgeInsets.symmetric(horizontal: this.widget.height * .03),
        child: CircleTaskWidget(
          index: indexOfFinished,
          startingAnimation: this.startAnimation,
          task: this.widget.listTasks[indexOfFinished],
          widgetSize: this.widget.height * .8,
        ),
      );
      //TODO3 : turn the next element into another element of the sack
      this._theNextElement = Container(
        height: this.widget.height * 1.23,
        width: this.widget.height * .86,
        padding: EdgeInsets.symmetric(horizontal: this.widget.height * .03),
        child: CircleTaskWidget(
          index: indexOfFinished + 1,
          startingAnimation: this.startAnimation,
          task: this.widget.listTasks[indexOfFinished + 1],
          widgetSize: this.widget.height * .8,
        ),
      );
      //TODO : saving the right and the left parts of the widget into the variables
      //! Saving the left part into a widget
      List<Widget> rightPartList = List<Widget>(),
          leftPartList = List<Widget>();
      this
          .widget
          .listTasks
          .sublist(0, indexOfFinished)
          .asMap()
          .forEach((index, task) {
        print("the left part taskText " + task.taskString);
        leftPartList.add(Container(
          height: this.widget.height * 1.23,
          width: this.widget.height * .86,
          padding: EdgeInsets.symmetric(horizontal: this.widget.height * .03),
          child: CircleTaskWidget(
            index: indexOfFinished + 2 + index,
            startingAnimation: this.startAnimation,
            task: task,
            widgetSize: this.widget.height * .8,
          ),
        ));
      });
      print("the left part length is " + leftPartList.length.toString());
      this._theLeftPart = Container(
        height: this.widget.height * 1.23,
        width: this.widget.height * .86 * leftPartList.length,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: leftPartList,
        ),
      );
      //!------------------------------------------------------------------

      //! Saving the right part into a widget
      this
          .widget
          .listTasks
          .sublist(indexOfFinished + 2)
          .asMap()
          .forEach((index, task) {
        rightPartList.add(Container(
          height: this.widget.height * 1.23,
          width: this.widget.height * .86,
          padding: EdgeInsets.symmetric(horizontal: this.widget.height * .03),
          child: CircleTaskWidget(
            index: indexOfFinished + 2 + index,
            startingAnimation: this.startAnimation,
            task: task,
            widgetSize: this.widget.height * .8,
          ),
        ));
      });
      this._theRightPart = Container(
        height: this.widget.height * 1.23,
        width: this.widget.height * .86 * rightPartList.length,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: rightPartList,
        ),
      );

      //!----------------------------------------------------------------------------------------
      //TODO4 : moving the finished Circle Task into the right (by passing under the next element)
      //! I did it int the build part, after starting the animation I move the element using a positioned widget by the factor of the aniamtion value
      //TODO5 : moving the right part of the list into the left by one block and also next element of the finished object
      //! I also did it in the build part by the same way
      this._animationController.forward();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    this._animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )
      ..addListener(() {
        setState(() {
          print(this._animationController.value);
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //TODO5 : Rearranging the list of tasks in the parent Widget
          setState(() {
            List<CircleTask> newTasks = List<CircleTask>();
            newTasks
                .addAll(this.widget.listTasks.sublist(0, this.finishedIndex));
            newTasks.add(this.widget.listTasks[this.finishedIndex + 1]);
            newTasks
                .addAll(this.widget.listTasks.sublist(this.finishedIndex + 2));
            newTasks.add(this.widget.listTasks[this.finishedIndex]);
            this.finishedIndex = null;
            this._animationController.value = 0;
            this.widget.listTasks = List<CircleTask>();
            this.widget.listTasks.addAll(newTasks);
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = getWidth(context);
    return this._animationController.isDismissed
        ? Container(
            height: this.widget.height * 1.23,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: this.widget.listTasks.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: this.widget.height * 1.23,
                  width: this.widget.height * .86,
                  padding: EdgeInsets.symmetric(
                      horizontal: this.widget.height * .03),
                  child: CircleTaskWidget(
                    index: index,
                    startingAnimation: this.startAnimation,
                    task: this.widget.listTasks[index],
                    widgetSize: this.widget.height * .8,
                  ),
                );
              },
            ),
          )
        : Container(
            height: this.widget.height * 1.23,
            child: Stack(children: [
              Positioned(
                child: this._theRightPart,
                left:
                    (this.finishedIndex + 2 - this._animationController.value) *
                        this.widget.height *
                        .86,
              ),
              Positioned(
                child: this._theFinishedElement,
                left: ((this.widget.height * .86) *
                        (this.widget.listTasks.length -
                            this.finishedIndex -
                            1) *
                        this._animationController.value) +
                    this.widget.height * this.finishedIndex * .86,
              ),
              Positioned(
                child: this._theNextElement,
                left:
                    (this.finishedIndex + 1 - this._animationController.value) *
                        this.widget.height *
                        .86,
              ),
              Positioned(
                left: 0,
                child: this._theLeftPart,
              ),
            ]),
          );
  }

  @override
  void dispose() {
    super.dispose();
    this._animationController.dispose();
  }
}
