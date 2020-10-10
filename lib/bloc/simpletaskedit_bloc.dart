import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';

part 'simpletaskedit_event.dart';
part 'simpletaskedit_state.dart';

class SimpletaskeditBloc
    extends Bloc<SimpletaskeditEvent, SimpletaskeditState> {
  SimpletaskeditBloc() : super(SimpletaskeditInitial(SimpleTask()));

  @override
  Stream<SimpletaskeditState> mapEventToState(
    SimpletaskeditEvent event,
  ) async* {
    if (event is CreateNewTask)
      yield NewTaskEditPage(SimpleTask());
    else {
      yield RefreshEditPage(event.simpleTask);
    }
  }
}
