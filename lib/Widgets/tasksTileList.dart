import 'package:flutter/material.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/colorBool.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/listSimpleTasksModel.dart';

class TaskTileList extends StatefulWidget {
  ListSimpleTasksModel listSimpleTasksModel;
  TaskTileList({
    @required this.listSimpleTasksModel,
  });
  @override
  _TaskTileListState createState() => _TaskTileListState();
}

class _TaskTileListState extends State<TaskTileList> {
  List<Widget> listOfDraggables = List<Widget>();

  bool fillTheListOfDragable() {
    try {
      this.listOfDraggables = List<Widget>();
      this.widget.listSimpleTasksModel.listSimpleTasks.forEach((element) {
        element.reset();
      });
      this.widget.listSimpleTasksModel.listSimpleTasks.asMap().forEach((index, colorBool) {
        this.listOfDraggables.add(Draggable<MapEntry<int, Color>>(
              child: Container(
                width: 100,
                height: 50,
                color: colorBool.color,
              ),
              feedback: Container(
                width: 100,
                height: 50,
                color: colorBool.color,
              ),
              data: MapEntry(index, colorBool.color),
              childWhenDragging: Container(
                width: 100,
                height: 50,
                color: colorBool.color.withOpacity(0.3),
              ),
            ));
        this.listOfDraggables.add(DragTarget<MapEntry<int, Color>>(
              onWillAccept: (value) {
                return true;
              },
              builder: (context, List<MapEntry<int, Color>> acceptedColors,
                  rejectedColors) {
                print("the makeBigger is " + colorBool.makeBigger.toString());
                colorBool.makeBigger++;
                return colorBool.makeBigger > 1
                    ? Container(
                        width: 100,
                        height: 30,
                        color: Colors.grey,
                      )
                    : Container(
                        width: 100,
                        height: 10,
                        color: Colors.white,
                      );
              },
              onAccept: (data) {
                setState(() {
                  this.widget.listSimpleTasksModel.listSimpleTasks.removeAt(data.key);
                  if (data.key > index) {
                    this
                        .widget.listSimpleTasksModel.listSimpleTasks
                        .insert(index + 1, ColorBool(color: data.value));
                  } else {
                    this
                        .widget.listSimpleTasksModel.listSimpleTasks
                        .insert(index, ColorBool(color: data.value));
                  }
                });
              },
              onLeave: (data) {
                colorBool.reset();
              },
            ));
      });
      setState(() {
        print("setStateCalled");
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    this.fillTheListOfDragable();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(this.widget.listSimpleTasksModel.title),
        Container(
          height: (this.widget.listSimpleTasksModel.listSimpleTasks.length * 2 * 50.0),
          width: 100,
          child: ListView(
            children: this.listOfDraggables,
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
