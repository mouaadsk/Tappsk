import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'simpletaskedit_event.dart';
part 'simpletaskedit_state.dart';

class SimpletaskeditBloc extends Bloc<SimpletaskeditEvent, SimpletaskeditState> {
  SimpletaskeditBloc() : super(SimpletaskeditInitial());

  @override
  Stream<SimpletaskeditState> mapEventToState(
    SimpletaskeditEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
