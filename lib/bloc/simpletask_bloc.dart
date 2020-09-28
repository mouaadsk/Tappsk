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
    if (event is StartAnimation) {
      event.animationController.forward();
      while (event.animationController.value != 1) {
        print(event.animationController.value);
        yield AnimationIsWorking();
      }
    } else if (event is CloseSimpleTaskEdit) {
      event.animationController.reverse();
      while (event.animationController.value > 0) {
        yield SimpleTaskEditClosed();
      }
      yield SimpletaskInitial();
    }
  }
}
