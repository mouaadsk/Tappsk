import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Shared/generaleFunctions.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';

class AddNoteWidget extends StatefulWidget {
  SimpleTask simpleTask;
  AddNoteWidget({Key key, this.simpleTask}) : super(key: key);
  @override
  _AddNoteWidgetState createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  TextEditingController textEditingController;
  FocusNode textFieldFocusNode;
  final dataKey = new GlobalKey();
  @override
  void initState() {
    super.initState();
    this.textEditingController = TextEditingController(
      text: this.widget.simpleTask.note != null
          ? this.widget.simpleTask.note
          : "",
    );
    textFieldFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = getWidth(context),
        screenHeight = getHeight(context);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.note_outlined,
            size: screenWidth * .08,
            color: this.widget.simpleTask.note != null
                ? Colors.blue
                : Colors.grey[400],
          ),
          SizedBox(
            width: screenWidth * .03,
          ),
          Container(
            width: screenWidth * .8,
            height: screenHeight* .2,
            margin: EdgeInsets.only(top : screenWidth * .02),
            child: TextField(
              key: dataKey,
              onTap: (){
                Scrollable.ensureVisible(dataKey.currentContext);
              },
              focusNode: this.textFieldFocusNode,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(1.0),
                hintText: "Add Note",
                border: InputBorder.none,
                isDense: true,
                hintStyle: GoogleFonts.rubik(
                  fontWeight: FontWeight.w500,
                  fontSize: screenHeight * .02,
                  color: Colors.grey[400],
                ),
              ),
              onEditingComplete: () {
                this.widget.simpleTask.note =
                    this.textEditingController.text.isEmpty ||
                            this.textEditingController.text == null
                        ? null
                        : this.textEditingController.text;
              },
              maxLines: 3,
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
