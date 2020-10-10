import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/SimpleTask%20Widgets/addingNoteWidget.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/SimpleTask%20Widgets/dateTimePickerWidget.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/SimpleTask%20Widgets/reccuringWidget.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/SimpleTask%20Widgets/reminderWidget.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/SubTask%20Widgets/addSubtaskWidget.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/SubTask%20Widgets/subTaskWidget.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/textEditOnClick.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/bloc/simpletask_bloc.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Shared/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/bloc/simpletaskedit_bloc.dart';

class SimpleTaskEditingPage extends StatefulWidget {
  final AnimationController animationController;
  const SimpleTaskEditingPage({
    Key key,
    @required this.animationController,
  }) : super(key: key);
  @override
  SimpleTaskEditingPageState createState() => SimpleTaskEditingPageState();
}

class SimpleTaskEditingPageState extends State<SimpleTaskEditingPage> {
  SimpletaskeditBloc blocSimpleTaskEdit;

  @override
  void initState() {
    super.initState();
    blocSimpleTaskEdit = context.bloc<SimpletaskeditBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = getWidth(context),
        screenHeight = getHeight(context);
    return BlocConsumer<SimpletaskeditBloc, SimpletaskeditState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(screenWidth * .08)),
              border: Border.all(
                color: Colors.transparent,
              ),
              color: Colors.grey[200]),
          height: screenHeight * .85,
          width: screenWidth * .98,
          child: Column(
            children: [
              Center(
                child: InkWell(
                  onTap: () async {
                    try {
                      print("minimize tapped");
                      SimpletaskBloc simpletaskBloc =
                          context.bloc<SimpletaskBloc>();
                      simpletaskBloc.add(
                        CloseSimpleTaskEdit(
                          animationController: this.widget.animationController,
                        ),
                      );
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: screenHeight * .02),
                    padding: EdgeInsets.all(10),
                    width: screenWidth * .13,
                    child: Image.asset("assets/images/arrow.png"),
                  ),
                ),
              ),
              Container(
                height: screenHeight * .85 -
                    ((screenHeight * .02) + screenWidth * .13 + 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: TextEditOnClick(
                          textStyle: GoogleFonts.rubik(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: screenWidth * .05,
                          ),
                          textEditingController:
                              state.simpleTask.titleEditingController,
                        ),
                      ),
                        SizedBox(
                          height: screenHeight * .02,
                        ),
                      if (state.simpleTask.subtasks != null &&
                          state.simpleTask.subtasks.isNotEmpty)
                        ...state.simpleTask.subtasks
                            .map((subtask) => SubTaskWidget(subTask: subtask))
                            .toList(),
                      if (state.simpleTask.subtasks != null &&
                          state.simpleTask.subtasks.isNotEmpty)
                        SizedBox(
                          height: screenHeight * .02,
                        ),
                      AddSubtaskWidget(simpleTask: state.simpleTask),
                      SizedBox(
                        height: screenHeight * .02,
                      ),
                      DateTimePickerWidget(
                        simpleTask: state.simpleTask,
                      ),
                      SizedBox(
                        height: screenHeight * .02,
                      ),
                      ReminderWidget(simpleTask: state.simpleTask),
                      RecurringTaskWidget(simpleTask: state.simpleTask),
                      AddNoteWidget(simpleTask: state.simpleTask),
                      SizedBox(height: screenHeight * .35),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
