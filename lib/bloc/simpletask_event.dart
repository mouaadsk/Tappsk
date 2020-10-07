part of 'simpletask_bloc.dart';

@immutable
abstract class SimpletaskEvent {
  final SimpleTask simpleTask;
  const SimpletaskEvent({
    this.simpleTask,
  });
}

class DisplaySimpleTaskEdit extends SimpletaskEvent {
  final SimpleTask simpleTask;
  DisplaySimpleTaskEdit({@required this.simpleTask});
}

class CloseSimpleTaskEdit extends SimpletaskEvent {
  final AnimationController animationController;
  const CloseSimpleTaskEdit({@required this.animationController});
}

class StartAnimation extends SimpletaskEvent {
  final AnimationController animationController;
  StartAnimation({@required this.animationController, SimpleTask simpleTask})
      : super(simpleTask: simpleTask);
}
