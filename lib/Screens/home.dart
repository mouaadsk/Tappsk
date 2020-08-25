import 'package:flutter/material.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/generaleFunctions.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = getWidth(context);
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Center(
            child: InkWell(
              splashColor: Colors.transparent,
              borderRadius: BorderRadius.circular(screenWidth * .15),
              enableFeedback: false,
              onTap: () {
                print("circle is clicked");
              },
              child: Container(
                width: screenWidth * .3,
                height: screenWidth * .3,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 3.0, color: Colors.lightBlue),
                    shape: BoxShape.circle,
                    color: Colors.white),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFfedcb1),
                        const Color(0xFFFBB1DB)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  width: screenWidth * 0.27,
                  height: screenWidth * 0.27,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
