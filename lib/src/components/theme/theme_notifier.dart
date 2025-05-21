import 'package:flutter/material.dart';

class ThemeNotifier {
  ThemeNotifier._();
  factory ThemeNotifier() => _instance;
  static final _instance = ThemeNotifier._();

  final mode = ValueNotifier(Brightness.light);
  void setMode(Brightness value) => mode.value = value;
  void toggleMode() {
    mode.value = switch (mode.value) {
      Brightness.light => Brightness.dark,
      Brightness.dark => Brightness.light,
    };
  }

  final _padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 16);

  ThemeData theme(Brightness mode) {
    return switch (mode) {
      Brightness.light => ThemeData(
          brightness: mode,
          fontFamily: 'Inter',
          cardColor: Colors.white,
          primaryColor: Colors.black,
          scaffoldBackgroundColor: const Color(0xFFF7F5EF),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black87),
            titleMedium: TextStyle(color: Colors.black),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            contentPadding: _padding,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            prefixIconColor: Colors.black54,
            hintStyle: const TextStyle(color: Colors.black45),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFF7F5EF),
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
      Brightness.dark => ThemeData(
          brightness: mode,
          fontFamily: 'Inter',
          primaryColor: Colors.white,
          cardColor: const Color(0xFF1E1E1E),
          scaffoldBackgroundColor: const Color(0xFF121212),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white70),
            titleMedium: TextStyle(color: Colors.white),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            contentPadding: _padding,
            fillColor: const Color(0xFF1E1E1E),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(24),
            ),
            prefixIconColor: Colors.white60,
            hintStyle: const TextStyle(color: Colors.white54),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF121212),
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
    };
  }

  static Color whiteOrBlackColor([Brightness? value]) {
    return switch (value ?? _instance.mode.value) {
      Brightness.light => Colors.black,
      Brightness.dark => Colors.white,
    };
  }

  static Color blackOrWhiteColor([Brightness? value]) {
    return switch (value ?? _instance.mode.value) {
      Brightness.dark => Colors.black,
      Brightness.light => Colors.white,
    };
  }

  Color colorByMode(Color light, Color dark) {
    return switch (mode.value) {
      Brightness.light => light,
      Brightness.dark => dark
    };
  }

  static iconColorByMode() =>
      ThemeNotifier().colorByMode(Colors.black54, Colors.white54);

  static borderColorByMode() =>
      ThemeNotifier().colorByMode(Colors.black12, Colors.white12);

  static textColorByMode() =>
      ThemeNotifier().colorByMode(Colors.black, Colors.white);
}
