part of 'simpletask_bloc.dart';

@immutable
abstract class SimpletaskState {
  final SimpleTask simpleTask;
  const SimpletaskState({this.simpleTask});
}

class SimpletaskInitial extends SimpletaskState {
  final SimpleTask simpleTask;
  const SimpletaskInitial({
    this.simpleTask,
  });
}

class SimpleTaskEditOpened extends SimpletaskState {
  final SimpleTask simpleTask;
  const SimpleTaskEditOpened({
    @required this.simpleTask,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SimpleTaskEditOpened && o.simpleTask == simpleTask;
  }

  @override
  int get hashCode => simpleTask.hashCode;
}

class SimpleTaskEditClosed extends SimpletaskState {
  const SimpleTaskEditClosed();
}

class AnimationIsWorking extends SimpletaskState {
  const AnimationIsWorking();
}

class InBetweenState extends SimpletaskState {
  const InBetweenState();
}
