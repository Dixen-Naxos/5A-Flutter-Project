part of 'theme_bloc.dart';


@immutable
abstract class ThemeEvent {}

class SetTheme extends ThemeEvent {
  final ThemeData theme;

  SetTheme({
    required this.theme
  });
}
