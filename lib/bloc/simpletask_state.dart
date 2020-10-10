part of 'simpletask_bloc.dart';

@immutable
abstract class SimpletaskState {
  SimpletaskState();
}

class SimpletaskInitial extends SimpletaskState {
  SimpletaskInitial();
}

class SimpleTaskEditOpened extends SimpletaskState {
  SimpleTaskEditOpened();

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SimpleTaskEditOpened;
  }
}

class SimpleTaskEditClosed extends SimpletaskState {
  SimpleTaskEditClosed();
}

class AnimationIsWorking extends SimpletaskState {
  AnimationIsWorking();
}

class InBetweenState extends SimpletaskState {
  InBetweenState();
}
