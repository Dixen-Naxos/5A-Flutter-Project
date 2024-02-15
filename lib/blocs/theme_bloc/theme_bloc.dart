import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(theme: ThemeData.light())) {
    on<SwitchThem>(_switchTheme);
    on<InitTheme>(_onInit);
  }

  void _switchTheme(event, emit) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isDarkTheme = !(sharedPreferences.getBool("isDarkTheme") ?? true);
    sharedPreferences.setBool("isDarkTheme", isDarkTheme);

    emit(
      state.setTheme(
        theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      ),
    );
  }

  void _onInit(event, emit) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    ThemeData theme = sharedPreferences.getBool("isDarkTheme") ?? true
        ? ThemeData.dark()
        : ThemeData.light();

    emit(
      state.setTheme(
        theme: theme,
      ),
    );
  }
}
