part of 'theme_bloc.dart';

class ThemeState {
  final ThemeData? theme;

  const ThemeState({
    required this.theme,
  });

  ThemeState setTheme({
    ThemeData? theme,
  }) {
    return ThemeState(
      theme: theme ?? this.theme,
    );
  }
}
