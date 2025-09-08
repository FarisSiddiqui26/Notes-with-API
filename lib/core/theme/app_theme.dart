import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeModeNotifier(prefs);
});

final themeColorProvider = StateNotifierProvider<ThemeColorNotifier, Color>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeColorNotifier(prefs);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final SharedPreferences _prefs;
  ThemeModeNotifier(this._prefs) : super(_prefs.getString('themeMode') == 'dark' ? ThemeMode.dark : ThemeMode.light);

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _prefs.setString('themeMode', state == ThemeMode.dark ? 'dark' : 'light');
  }
}

class ThemeColorNotifier extends StateNotifier<Color> {
  final SharedPreferences _prefs;
  ThemeColorNotifier(this._prefs) : super(Colors.blue) { // Default color
    final colorValue = _prefs.getInt('themeColor');
    if (colorValue != null) {
      state = Color(colorValue);
    }
  }

  void changeColor(Color color) {
    state = color;
    _prefs.setInt('themeColor', color.value);
  }
}

ThemeData lightTheme(Color seedColor) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  );
}

ThemeData darkTheme(Color seedColor) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}