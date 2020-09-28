part of 'simpletask_bloc.dart';

@immutable
abstract class SimpletaskEvent {
  const SimpletaskEvent();
}

class DisplaySimpleTaskEdit extends SimpletaskEvent {
  final SimpleTask simpleTask;
  DisplaySimpleTaskEdit({@required this.simpleTask});
}

class CloseSimpleTaskEdit extends SimpletaskEvent {
  final AnimationController animationController;
  const CloseSimpleTaskEdit({this.animationController});
}

class StartAnimation extends SimpletaskEvent {
  final AnimationController animationController;
  StartAnimation({@required this.animationController});
}
