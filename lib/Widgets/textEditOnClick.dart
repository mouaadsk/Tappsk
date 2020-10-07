import 'package:flutter/material.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/emuns.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/Shared/generaleFunctions.dart';

class TextEditOnClick extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextStyle textStyle;
  const TextEditOnClick({
    Key key,
    @required this.textEditingController,
    @required this.textStyle,
  }) : super(key: key);
  @override
  _TextEditOnClickState createState() => _TextEditOnClickState();
}

class _TextEditOnClickState extends State<TextEditOnClick> {
  TextOrEdit textOrEdit = TextOrEdit.Text;
  FocusNode textFieldFocusNode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //! in here I added a listener of the focus node to see if the textField is focused ot not (and if it is not I change the field to A text)
    textFieldFocusNode = FocusNode()
      ..addListener(() {
        if (!this.textFieldFocusNode.hasFocus)
          this.textOrEdit = TextOrEdit.Text;
      });
  }

  @override
  Widget build(BuildContext context) {
    final double width = getWidth(context), screenHeight = getHeight(context);
    return Container(
      alignment: Alignment.centerLeft,
      height: this.widget.textStyle.fontSize * 1.50,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            this.textOrEdit = this.textOrEdit == TextOrEdit.Edit
                ? TextOrEdit.Text
                : TextOrEdit.Edit;
          });
        },
        child: this.textOrEdit == TextOrEdit.Text
            ? Text(
                this.widget.textEditingController.text,
                style: this.widget.textStyle,
              )
            : TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(1.0),
                hintText: "Task Title",
                border: InputBorder.none,
                isDense: true,
              ),
                focusNode: this.textFieldFocusNode,
                autofocus: true,
                onEditingComplete: () {
                  print("Edition Complete");
                  this.textFieldFocusNode.nextFocus();
                },
                textDirection: TextDirection.ltr,
                controller: this.widget.textEditingController,
                style: this.widget.textStyle,
              ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this.textFieldFocusNode.dispose();
  }
}
