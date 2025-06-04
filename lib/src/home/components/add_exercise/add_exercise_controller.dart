import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../../shared/states/index.dart';
import '../../../../core/entities/index.dart';
import '../../../../shared/index.dart';

class AddExerciseController {
  final isLoading = InLoading();
  final categories = ListStateOf<Category>([]);
  final weekdays = ListStateOf<int>.first(Utils.getWeekday());

  Future<void> create(
    String name, {
    required int series,
    required int repetitions,
    required ValueChanged<Exercise?> onCreated,
  }) async {
    isLoading.toggle();

    Exercise? dto;

    try {
      dto = await repository.createExercise(
        name: name,
        days: weekdays.value..sort(),
        max: MapEntry(series, repetitions),
        categories: categories.value.map((it) => it.id).toList(),
      );
    } catch (e) {
      Utils.errorToast(e.toString());
    } finally {
      isLoading.toggle();
      onCreated.call(dto);
    }
  }

  void dispose() {
    weekdays.dispose();
    categories.dispose();
  }
}
