import 'package:flutter/material.dart';

import 'src/components/index.dart';
import 'src/home/index.dart';

import 'shared/index.dart';

class GymApp extends StatefulWidget {
  const GymApp({super.key});

  @override
  State<GymApp> createState() => _GymAppState();
}

class _GymAppState extends State<GymApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(LoadingImages().loadingAll);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (mode, themeData) => MaterialApp(
        home: _body(),
        theme: themeData,
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: Utils.scaffoldKey,
      ),
    );
  }

  Widget _body() {
    return FutureBuilder(
      future: LoadingImages().loadingAll(),
      builder: (context, snapshot) {
        return switch (snapshot.connectionState) {
          ConnectionState.done => const HomeScreen(),
          _ => const Center(child: Loading()),
        };
      },
    );
  }
}
