import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Shared/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/bloc/simpletaskedit_bloc.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/subtask.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSubtaskWidget extends StatefulWidget {
  SimpleTask simpleTask;
  AddSubtaskWidget({Key key, this.simpleTask}) : super(key: key);
  @override
  _AddSubtaskWidgetState createState() => _AddSubtaskWidgetState();
}

class _AddSubtaskWidgetState extends State<AddSubtaskWidget> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode textFieldFocusNode;
  @override
  void initState() {
    super.initState();
    this.textFieldFocusNode = FocusNode();
    textEditingController = TextEditingController();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = getHeight(context),
        screenWidth = getWidth(context);
    return Container(
      height: screenHeight * .02 * 1.50,
      alignment: Alignment.centerLeft,
      width: screenWidth * .90,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              child: Icon(
                Icons.arrow_forward,
                color: Colors.grey[400],
                size: screenWidth * .06,
              ),
              onTap: () {
                //TODO : adding the logic of adding the subtask to te simpleTask
                setState(() {
                  this.widget.simpleTask.subtasks.add(SubTask(
                        title: this.textEditingController.text,
                      ));
                  this.textEditingController.text = "";
                  this.textFieldFocusNode.nextFocus();
                  context.bloc<SimpletaskeditBloc>().add(DoRefreshEditPage());
                });
              }),
          SizedBox(
            width: screenWidth * .03,
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: screenWidth * .75,
            height: screenHeight * .02 * 1.50,
            child: TextField(
              focusNode: this.textFieldFocusNode,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(1.0),
                hintText: "Add SubTask",
                border: InputBorder.none,
                isDense: true,
                hintStyle: GoogleFonts.rubik(
                  fontWeight: FontWeight.w500,
                  fontSize: screenHeight * .02,
                  color: Colors.grey[400],
                ),
              ),
              onEditingComplete: () {},
              textDirection: TextDirection.ltr,
              controller: this.textEditingController,
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.normal,
                fontSize: screenHeight * .02,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
