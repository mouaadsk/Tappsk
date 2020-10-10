import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/SimpleTask%20Widgets/taskTile.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/bloc/simpletask_bloc.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Shared/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/bloc/simpletaskedit_bloc.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/listSimpleTasksModel.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/subtask.dart';

class TaskTileList extends StatefulWidget {
  ListSimpleTasksModel listSimpleTasksModel;
  AnimationController editTaskAnimationcontroller;
  TaskTileList({
    @required this.listSimpleTasksModel,
    @required this.editTaskAnimationcontroller,
  });
  @override
  _TaskTileListState createState() => _TaskTileListState();
}

class _TaskTileListState extends State<TaskTileList> {
  double screenHeight, screenWidth;
  List<SimpleTask> listSimpleTasks = [
        SimpleTask(
          subtasks: List<SubTask>(),
          boxColor: Colors.lightGreen,
          title: "Eating vegetables",
          repeated: true,
        ),
        SimpleTask(
          subtasks: List<SubTask>(),
          boxColor: Colors.lightBlue,
          title: "Drinking more water",
          repeated: true,
        ),
        SimpleTask(
          subtasks: List<SubTask>(),
          boxColor: Colors.redAccent,
          title: "Rest",
        ),
        SimpleTask(
          subtasks: List<SubTask>(),
          boxColor: Colors.purpleAccent,
          title: "IDK",
        ),
      ],
      thisWeekSimpleTasks = [
        SimpleTask(
          subtasks: List<SubTask>(),
          boxColor: Colors.lightGreen,
          title: "Eating vegetables",
          repeated: true,
        ),
        SimpleTask(
          subtasks: List<SubTask>(),
          boxColor: Colors.lightBlue,
          title: "Drinking more water",
          repeated: true,
        ),
        SimpleTask(
          subtasks: List<SubTask>(),
          boxColor: Colors.redAccent,
          title: "Rest",
        ),
        SimpleTask(
          subtasks: List<SubTask>(),
          boxColor: Colors.purpleAccent,
          title: "IDK",
        ),
        SimpleTask(
          subtasks: List<SubTask>(),
          boxColor: Colors.amber,
          title: "Eating dinner",
          finishingDate: DateTime.now(),
        ),
        SimpleTask(
          subtasks: List<SubTask>(),
          boxColor: Colors.black,
          title: "Reading a book",
          finishingDate: DateTime.now().add(Duration(days: 1)),
        ),
        SimpleTask(
          subtasks: List<SubTask>(),
          boxColor: Colors.red,
          title: "Workout",
          finishingDate: DateTime.now().add(Duration(days: 7)),
        ),
        SimpleTask(
          subtasks: List<SubTask>(),
          boxColor: Colors.blue,
          title: "Drinking Water",
          repeated: true,
        ),
      ];

  ListSimpleTasksModel listSimpleTasksModel, thisWeekListSimpleTasksModel;
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
          child: InkWell(
            onTap: () {
              //! the OnTap of the TaskTile
              context.bloc<SimpletaskeditBloc>().add(TaskEdited(simpleTask));
              BlocProvider.of<SimpletaskBloc>(context).add(StartAnimation(
                  animationController: this.widget.editTaskAnimationcontroller,
                  simpleTask: simpleTask));
            },
            child: TaskTile(simpleTask: simpleTask),
          ),
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
    thisWeekListSimpleTasksModel = ListSimpleTasksModel(
        listSimpleTasks: this.thisWeekSimpleTasks, title: "This week");
    this.fillTheListOfDragable(this.widget.listSimpleTasksModel);
    this.fillTheListOfDragable(this.listSimpleTasksModel);
    this.fillTheListOfDragable(this.thisWeekListSimpleTasksModel);
  }

  @override
  Widget build(BuildContext context) {
    if (screenHeight == null) {
      screenWidth = getWidth(context);
      screenHeight = getHeight(context);
    }
    return this.widget.listSimpleTasksModel.listOfDraggables != null &&
            this.listSimpleTasksModel.listOfDraggables != null &&
            this.thisWeekListSimpleTasksModel.listOfDraggables != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    this.widget.listSimpleTasksModel.title,
                    style: GoogleFonts.bebasNeue(
                      fontSize: screenHeight * 0.05,
                      fontWeight: FontWeight.normal,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: screenWidth * .02),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(screenWidth * .03),
                    ),
                    width: screenWidth * .1,
                    height: screenHeight * .025,
                    alignment: Alignment.center,
                    child: Text(
                      "3/" +
                          this
                              .widget
                              .listSimpleTasksModel
                              .listSimpleTasks
                              .length
                              .toString(),
                      style: GoogleFonts.roboto(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Container(
                width: screenWidth * .9,
                child: Column(
                  children: this.widget.listSimpleTasksModel.listOfDraggables,
                ),
              ),
              Row(
                children: [
                  Text(
                    this.listSimpleTasksModel.title,
                    style: GoogleFonts.bebasNeue(
                      fontSize: screenHeight * 0.05,
                      fontWeight: FontWeight.normal,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: screenWidth * .02),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(screenWidth * .03),
                    ),
                    width: screenWidth * .1,
                    height: screenHeight * .025,
                    alignment: Alignment.center,
                    child: Text(
                      "1/" +
                          this
                              .listSimpleTasksModel
                              .listSimpleTasks
                              .length
                              .toString(),
                      style: GoogleFonts.roboto(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Container(
                width: screenWidth * .9,
                child: Column(
                  children: this.listSimpleTasksModel.listOfDraggables,
                ),
              ),
              Row(
                children: [
                  Text(
                    this.thisWeekListSimpleTasksModel.title,
                    style: GoogleFonts.bebasNeue(
                      fontSize: screenHeight * 0.05,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: screenWidth * .02),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(screenWidth * .03),
                    ),
                    width: screenWidth * .1,
                    height: screenHeight * .025,
                    alignment: Alignment.center,
                    child: Text(
                      "2/" +
                          this
                              .thisWeekListSimpleTasksModel
                              .listSimpleTasks
                              .length
                              .toString(),
                      style: GoogleFonts.roboto(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Container(
                width: screenWidth * .9,
                child: Column(
                  children: this.thisWeekListSimpleTasksModel.listOfDraggables,
                ),
              ),
            ],
          )
        : Container(color: Colors.amber);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
