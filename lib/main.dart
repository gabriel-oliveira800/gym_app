import 'package:flutter/material.dart';

import 'core/external/isar_database.dart';
import 'core/repository/index.dart';
import 'gym_app.dart';

final repository = Repository(IsarDatabase());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarDatabase().init();
  runApp(const GymApp());
}
