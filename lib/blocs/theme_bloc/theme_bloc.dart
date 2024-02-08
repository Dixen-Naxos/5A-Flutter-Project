import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(theme: ThemeData.light())) {
    on<SetTheme>(_setTheme);
  }

  void _setTheme(event, emit) async {
    emit(
      state.setTheme(theme: event.theme),
    );
  }
}
