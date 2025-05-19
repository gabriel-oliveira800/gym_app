import 'package:flutter/material.dart';

import 'src/components/index.dart';
import 'src/screens/index.dart';

import 'shared/index.dart';

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (mode, themeData) => MaterialApp(
        theme: themeData,
        title: Strings.appName,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
