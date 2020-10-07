import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Shared/generalStyles.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/subTaskWidget.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Widgets/textEditOnClick.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/bloc/simpletask_bloc.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Shared/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';

class SimpleTaskEditingPage extends StatefulWidget {
  final SimpleTask simpleTask;
  final AnimationController animationController;
  const SimpleTaskEditingPage({
    Key key,
    @required this.simpleTask,
    @required this.animationController,
  }) : super(key: key);
  @override
  SimpleTaskEditingPageState createState() => SimpleTaskEditingPageState();
}

class SimpleTaskEditingPageState extends State<SimpleTaskEditingPage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = getWidth(context),
        screenHeight = getHeight(context);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * .08),
          color: Colors.blueGrey),
      height: screenHeight * .85,
      width: screenWidth * .98,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          TextEditOnClick(
            textStyle: GoogleFonts.rubik(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: screenWidth * .05,
            ),
            textEditingController:
                this.widget.simpleTask.titleEditingController,
          ),
          SizedBox(
            height: screenHeight * .05,
          ),
          ...this
              .widget
              .simpleTask
              .subtasks
              .map((subtask) => SubTaskWidget(subTask: subtask))
              .toList(),
        ],
      ),
    );
  }
}
