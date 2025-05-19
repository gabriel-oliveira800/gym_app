import 'package:flutter/material.dart';

import 'theme_notifier.dart';

typedef ThemeWrapperBuilder = Widget Function(Brightness mode, ThemeData theme);

class ThemeWrapper extends StatelessWidget {
  final ThemeWrapperBuilder builder;
  const ThemeWrapper({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final notifier = ThemeNotifier();

    return ValueListenableBuilder<Brightness>(
      valueListenable: notifier.mode,
      builder: (_, mode, child) => builder(mode, notifier.theme(mode)),
    );
  }
}
