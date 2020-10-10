part of 'simpletaskedit_bloc.dart';

@immutable
abstract class SimpletaskeditEvent {
  SimpleTask simpleTask;
  SimpletaskeditEvent({this.simpleTask});
}

class TaskEdited extends SimpletaskeditEvent {
  TaskEdited(
    SimpleTask simpleTask,
  ) : super(
          simpleTask: simpleTask,
        );
}

class CreateNewTask extends SimpletaskeditEvent {
  CreateNewTask();
}


class DoRefreshEditPage extends SimpletaskeditEvent{
  DoRefreshEditPage();
}