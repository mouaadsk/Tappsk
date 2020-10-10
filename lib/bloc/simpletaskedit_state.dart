part of 'simpletaskedit_bloc.dart';

@immutable
abstract class SimpletaskeditState {
  SimpleTask simpleTask;
  SimpletaskeditState({
    this.simpleTask,
  });
}

class SimpletaskeditInitial extends SimpletaskeditState {
  SimpletaskeditInitial(
    SimpleTask simpleTask,
  ) : super(
          simpleTask: simpleTask,
        );
}

class RefreshEditPage extends SimpletaskeditState {
  RefreshEditPage(
    SimpleTask simpleTask,
  ) : super(
          simpleTask: simpleTask,
        );
}

class NewTaskEditPage extends SimpletaskeditState {
  NewTaskEditPage(
    SimpleTask simpleTask,
  ) : super(
          simpleTask: simpleTask,
        );
}
