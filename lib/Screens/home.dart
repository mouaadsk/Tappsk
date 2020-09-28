import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/circleTasksList.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/tasksTileList.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/bloc/simpletask_bloc.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/circletask.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/listSimpleTasksModel.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/tempVars.dart';

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
      boxColor: Colors.amber,
      description: "Eating dinner",
      finishDateTime: DateTime.now(),
    ),
    SimpleTask(
      boxColor: Colors.black,
      description: "Reading a book",
      finishDateTime: DateTime.now().add(Duration(days: 1)),
    ),
    SimpleTask(
      boxColor: Colors.red,
      description: "Workout",
      finishDateTime: DateTime.now().add(Duration(days: 7)),
    ),
    SimpleTask(
      boxColor: Colors.blue,
      description: "Drinking Water",
      repeated: true,
    ),
  ];
  @override
  void initState() {
    super.initState();
    simpleTaskAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    simpleTaskAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = getWidth(context),
        screenHeight = getHeight(context);
    return Scaffold(
      body: SafeArea(
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
                          listSimpleTasksModel: ListSimpleTasksModel(
                              listSimpleTasks: this.listSimpleTasks,
                              title: "Today"),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocConsumer<SimpletaskBloc, SimpletaskState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is SimpletaskInitial) {
                      return Positioned(
                          right: screenWidth * .04,
                          bottom: screenWidth * .04,
                          child: RawMaterialButton(
                            onPressed: () {
                              final simpletaskBloc =
                                  context.bloc<SimpletaskBloc>();
                              simpletaskBloc.add(StartAnimation(
                                  animationController:
                                      this.simpleTaskAnimationController));
                              simpletaskBloc.close();
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
                    }
                    if (state is AnimationIsWorking) {
                      //TODO : I need to add the edit page of the task and opening it by starting an animation and passing the simpleTask To The Page
                      print("animation is working");
                      return Positioned(
                        top: screenHeight -
                            (screenHeight *
                                0.8 *
                                this.simpleTaskAnimationController.value),
                        left: screenWidth * .01,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenWidth * .08),
                            color: Colors.black,
                          ),
                          height: screenHeight * .85,
                          width: screenWidth * .98,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin:
                                      EdgeInsets.only(top: screenHeight * .02),
                                  width: screenWidth * .1,
                                  child:
                                      Image.asset("assets/images/arrow.png")),
                            ],
                          ),
                        ),
                      );
                    }
                    if (state is SimpleTaskEditClosed) {
                      //TODO : I need to close the page of editing the simpleTask and saving its state (saving the data changed of the simpleTask)
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
