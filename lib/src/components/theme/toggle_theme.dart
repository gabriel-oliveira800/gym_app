import 'package:flutter/material.dart';

import '../index.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (mode, theme) => IconButton(
        onPressed: ThemeNotifier().toggleMode,
        icon: Icon(
          color: ThemeNotifier.whiteOrBlackColor(),
          switch (mode) {
            Brightness.light => Icons.dark_mode,
            Brightness.dark => Icons.light_mode,
          },
        ),
      ),
    );
  }
}
