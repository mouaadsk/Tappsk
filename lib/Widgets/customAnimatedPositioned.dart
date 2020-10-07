import 'package:flutter/material.dart';

class CustomAnimatedPositioned extends StatefulWidget {
  final AnimationController animationController;
  final double startLeft, endLeft, startTop, endTop;
  final Widget child;
  final Duration duration;
  final Curve curve;
  const CustomAnimatedPositioned({
    Key key,
    @required this.animationController,
    @required this.endTop,
    @required this.child,
    @required this.startLeft,
    @required this.endLeft,
    @required this.startTop,
    @required this.duration,
    @required this.curve,
  }) : super(key: key);
  @override
  _CustomAnimatedPositionedState createState() =>
      _CustomAnimatedPositionedState();
}

class _CustomAnimatedPositionedState extends State<CustomAnimatedPositioned> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.widget.animationController.addStatusListener((status) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: widget.curve,
      duration: widget.duration,
      left: this.widget.animationController.isCompleted
          ? this.widget.endLeft
          : this.widget.startLeft,
      top: this.widget.animationController.isCompleted
          ? this.widget.endTop
          : this.widget.startTop,
      child: this.widget.child,
    );
  }
}
