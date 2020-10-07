import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tappsk_to_do_list_habit_tracker_and_reminder/models/simpleTask.dart';

part 'simpletask_event.dart';
part 'simpletask_state.dart';

class SimpletaskBloc extends Bloc<SimpletaskEvent, SimpletaskState> {
  SimpletaskBloc() : super(SimpletaskInitial());

  @override
  Stream<SimpletaskState> mapEventToState(
    SimpletaskEvent event,
  ) async* {
    print("batata");
    if (event is StartAnimation) {
      try {
        event.animationController.forward();
        yield AnimationIsWorking();
        yield SimpleTaskEditOpened(simpleTask: event.simpleTask);
      } catch (e) {
        print(e.toString());
      }
    } else if (event is CloseSimpleTaskEdit) {
      await event.animationController.reverse();
      yield SimpleTaskEditClosed();
      await Future.delayed(Duration(milliseconds: 200), () {});
      yield SimpletaskInitial();
    }
  }
}
