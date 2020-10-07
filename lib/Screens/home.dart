import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/circleTasksList.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/customAnimatedPositioned.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/simpleTaskEditingPage.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/tasksTileList.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/bloc/simpletask_bloc.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Shared/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/circletask.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/listSimpleTasksModel.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/subtask.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Shared/tempVars.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _controller, simpleTaskAnimationController;
  CircleTask tempTask = tempTasks[3];
  Color color = Colors.transparent;
  List<SimpleTask> listSimpleTasks = [
    SimpleTask(
      subtasks: List<SubTask>(),
      boxColor: Colors.amber,
      title: "Eating dinner",
      finishDateTime: DateTime.now(),
    ),
    SimpleTask(
      subtasks: List<SubTask>()
        ..add(
          SubTask(title: "Reading 1st 30 Pages"),
        ),
      boxColor: Colors.black,
      title: "Reading a book",
      finishDateTime: DateTime.now().add(Duration(days: 1)),
    ),
    SimpleTask(
      subtasks: List<SubTask>(),
      boxColor: Colors.red,
      title: "Workout",
      finishDateTime: DateTime.now().add(Duration(days: 7)),
    ),
    SimpleTask(
      subtasks: List<SubTask>(),
      boxColor: Colors.blue,
      title: "Drinking Water",
      repeated: true,
    ),
  ];
  @override
  void initState() {
    super.initState();
    simpleTaskAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 10),
    );
    simpleTaskAnimationController.addListener(() {
      print("value of animation controller is" +
          simpleTaskAnimationController.value.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    simpleTaskAnimationController.dispose();
    context.bloc<SimpletaskBloc>().close();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = getWidth(context),
        screenHeight = getHeight(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
          }
        },
        child: SafeArea(
          child: Expanded(
            child: BlocProvider(
              create: (context) => SimpletaskBloc(),
              child: Stack(
                children: [
                  ScrollConfiguration(
                    behavior: ScrollBehavior()
                      ..buildViewportChrome(
                        context,
                        null,
                        AxisDirection.down,
                      ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(12.5, 12.5, 0, 12.5),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.menu),
                              Icon(
                                Icons.check,
                                color: Colors.lightBlue,
                                size: screenWidth * .07,
                              ),
                              Container(
                                height: screenWidth * .07,
                                width: screenWidth * .07,
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: screenWidth * .07,
                                    ),
                                    Center(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          top: screenWidth * .01,
                                        ),
                                        child: Text(
                                          DateTime.now().day.toString(),
                                          style: TextStyle(
                                              fontSize: screenWidth * .03,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          CircleTasksList(
                            height: screenWidth * .3,
                            listTasks: tempTasks,
                          ),
                          TaskTileList(
                            editTaskAnimationcontroller:
                                this.simpleTaskAnimationController,
                            listSimpleTasksModel: ListSimpleTasksModel(
                                listSimpleTasks: this.listSimpleTasks,
                                title: "Today"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocConsumer<SimpletaskBloc, SimpletaskState>(
                    listener: (context, state) {
                      print("this is the listener");
                    },
                    builder: (context, state) {
                      if (state is SimpletaskInitial) {
                        return Positioned(
                            right: screenWidth * .04,
                            bottom: screenWidth * .04,
                            child: RawMaterialButton(
                              onPressed: () async {
                                SimpletaskBloc simpletaskBloc =
                                    context.bloc<SimpletaskBloc>();
                                simpletaskBloc.add(
                                  StartAnimation(
                                      animationController:
                                          this.simpleTaskAnimationController,
                                      simpleTask: this.listSimpleTasks[1]),
                                );
                              },
                              elevation: 2.0,
                              fillColor: Colors.lightBlue,
                              child: Icon(
                                Icons.add,
                                size: screenWidth * .1,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(screenWidth * .04),
                              shape: CircleBorder(),
                            ));
                      } else {
                        //TODO : I need to add the edit page of the task and opening it by starting an animation and passing the simpleTask To The Page
                        if (state is SimpleTaskEditOpened)
                          print("simple state title" + state.simpleTask.title);
                        return CustomAnimatedPositioned(
                          animationController:
                              this.simpleTaskAnimationController,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          startTop: screenHeight,
                          endTop: screenHeight * 0.2,
                          startLeft: screenWidth * .01,
                          endLeft: screenWidth * .01,
                          child: GestureDetector(
                              child: SimpleTaskEditingPage(
                            animationController:
                                this.simpleTaskAnimationController,
                            simpleTask: state.simpleTask,
                          )),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
