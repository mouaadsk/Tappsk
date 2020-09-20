import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/taskTile.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/colorBool.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/listSimpleTasksModel.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';

class TaskTileList extends StatefulWidget {
  ListSimpleTasksModel listSimpleTasksModel;
  TaskTileList({
    @required this.listSimpleTasksModel,
  });
  @override
  _TaskTileListState createState() => _TaskTileListState();
}

class _TaskTileListState extends State<TaskTileList> {
  double screenHeight, screenWidth;
  List<SimpleTask> listSimpleTasks = [
    SimpleTask(
      boxColor: Colors.lightGreen,
      description: "Eating vegetables",
      repeated: true,
    ),
    SimpleTask(
      boxColor: Colors.lightBlue,
      description: "Drinking more water",
      repeated: true,
    ),
    SimpleTask(
      boxColor: Colors.redAccent,
      description: "Rest",
    ),
    SimpleTask(
      boxColor: Colors.purpleAccent,
      description: "IDK",
    ),
  ];

  ListSimpleTasksModel listSimpleTasksModel;
  Future<bool> fillTheListOfDragable(
    ListSimpleTasksModel listSimpleTasksModel,
  ) async {
    try {
      listSimpleTasksModel.listOfDraggables = List<Widget>();
      listSimpleTasksModel.reset();
      //! adding a dragTarget in the begining of the list of the draggables
      listSimpleTasksModel.listOfDraggables
          .add(DragTarget<MapEntry<int, ListSimpleTasksModel>>(
        onWillAccept: (value) {
          return true;
        },
        builder: (context,
            List<MapEntry<int, ListSimpleTasksModel>> acceptedTasks,
            rejectedColors) {
          listSimpleTasksModel.firstInt++;
          return listSimpleTasksModel.firstInt > 1
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: TaskTile(simpleTask: null),
                )
              : Container(
                  width: screenWidth * .9,
                  height: 5,
                  color: Colors.white,
                );
        },
        onAccept: (data) {
          setState(() {
            try {
              //! saving the delted widget in a temp variable
              SimpleTask tempSimpleTask = data.value.listSimpleTasks[data.key];
              data.value.deleteElementIndex(data.key);
              listSimpleTasksModel.addeElementIndex(0, tempSimpleTask);
              //! refrshing the draggable widgets inside the Listmodel
              this.fillTheListOfDragable(listSimpleTasksModel);
              this.fillTheListOfDragable(data.value);
            } catch (e) {
              print(e.toString());
            }
          });
        },
        onLeave: (data) {
          listSimpleTasksModel.firstInt = 0;
        },
      ));
      listSimpleTasksModel.listSimpleTasks.asMap().forEach((index, simpleTask) {
        listSimpleTasksModel.listOfDraggables
            .add(Draggable<MapEntry<int, ListSimpleTasksModel>>(
          child: TaskTile(simpleTask: simpleTask),
          feedback: TaskTile(simpleTask: simpleTask),
          data: MapEntry(index, listSimpleTasksModel),
          childWhenDragging: Container(height: 0),
        ));
        listSimpleTasksModel.listOfDraggables
            .add(DragTarget<MapEntry<int, ListSimpleTasksModel>>(
          onWillAccept: (value) {
            return true;
          },
          builder: (context,
              List<MapEntry<int, ListSimpleTasksModel>> acceptedTasks,
              rejectedColors) {
            simpleTask.makeBigger++;
            return simpleTask.makeBigger > 1
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: TaskTile(simpleTask: null),
                  )
                : Container(
                    width: screenWidth * .9,
                    height: 5,
                    color: Colors.white,
                  );
          },
          onAccept: (data) {
            setState(() {
              try {
                SimpleTask tempSimpleTask =
                    data.value.listSimpleTasks[data.key];
                data.value.deleteElementIndex(data.key);
                if (data.key > index && listSimpleTasksModel == data.value ||
                    data.value != listSimpleTasksModel) {
                  listSimpleTasksModel.addeElementIndex(
                      index + 1, tempSimpleTask);
                } else {
                  listSimpleTasksModel.addeElementIndex(index, tempSimpleTask);
                }
                this.fillTheListOfDragable(listSimpleTasksModel);
                this.fillTheListOfDragable(data.value);
              } catch (e) {
                print(e.toString());
              }
            });
          },
          onLeave: (data) {
            simpleTask.reset();
          },
        ));
      });
      //! adding a drag target in the end of the list of draggables
      listSimpleTasksModel.listOfDraggables
          .add(DragTarget<MapEntry<int, ListSimpleTasksModel>>(
        onWillAccept: (value) {
          return true;
        },
        builder: (context,
            List<MapEntry<int, ListSimpleTasksModel>> acceptedTasks,
            rejectedColors) {
          listSimpleTasksModel.lastInt++;
          return listSimpleTasksModel.lastInt > 1
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: TaskTile(simpleTask: null),
                )
              : Container(
                  width: screenWidth * .9,
                  height: 5,
                  color: Colors.white,
                );
        },
        onAccept: (data) {
          setState(() {
            try {
              SimpleTask tempSimpleTask = data.value.listSimpleTasks[data.key];
              data.value.deleteElementIndex(data.key);
              listSimpleTasksModel.addeElementIndex(
                  listSimpleTasksModel.listSimpleTasks.length, tempSimpleTask);
              this.fillTheListOfDragable(listSimpleTasksModel);
              this.fillTheListOfDragable(data.value);
            } catch (e) {
              print(e.toString());
            }
          });
        },
        onLeave: (data) {
          listSimpleTasksModel.lastInt = 0;
        },
      ));
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
  void initState() {
    // TODO: implement initState
    super.initState();
    listSimpleTasksModel = ListSimpleTasksModel(
        listSimpleTasks: listSimpleTasks, title: "Tommorow");
    this.fillTheListOfDragable(this.widget.listSimpleTasksModel);
    this.fillTheListOfDragable(this.listSimpleTasksModel);
  }

  @override
  Widget build(BuildContext context) {
    if (screenHeight == null) {
      screenWidth = getWidth(context);
      screenHeight = getHeight(context);
    }
    return this.widget.listSimpleTasksModel.listOfDraggables != null &&
            this.listSimpleTasksModel.listOfDraggables != null
        ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.widget.listSimpleTasksModel.title,
                  style: GoogleFonts.bebasNeue(
                    fontSize: screenHeight * 0.05,
                    fontWeight: FontWeight.normal,
                    color: Colors.blue,
                  ),
                ),
                Container(
                  width: screenWidth * .9,
                  child: Column(
                    children: this.widget.listSimpleTasksModel.listOfDraggables,
                  ),
                ),
                Text(
                  this.listSimpleTasksModel.title,
                  style: GoogleFonts.bebasNeue(
                    fontSize: screenHeight * 0.05,
                    fontWeight: FontWeight.normal,
                    color: Colors.blue,
                  ),
                ),
                Container(
                  width: screenWidth * .9,
                  child: Column(
                    children: this.listSimpleTasksModel.listOfDraggables,
                  ),
                ),
              ],
            ),
          )
        : Container(color: Colors.amber);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
