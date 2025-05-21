import 'package:flutter/material.dart';

import '../src/components/index.dart';

abstract class AppColors {
  static const Color categoryTextActive = Colors.white;
  static const Color categoryTextDisable = Color.fromARGB(255, 72, 71, 71);

  static const Color categoryBgDisable = Colors.white;
  static const Color categoryBgActive = Color(0xFF22252A);

  static const Color fabBgColor = Color(0xFF202123);

  static Color get modalAdaptiveColor => ThemeNotifier().colorByMode(
        const Color(0xFFF7F5EF),
        categoryBgActive,
      );
}
