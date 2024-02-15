part of 'theme_bloc.dart';


@immutable
abstract class ThemeEvent {}

class SwitchThem extends ThemeEvent {}

class InitTheme extends ThemeEvent {}
