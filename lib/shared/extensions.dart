import 'package:flutter/material.dart';

import '../core/index.dart';
import 'strings.dart';

extension DateTimeExtensions on DateTime {
  String goodWithDate() {
    return switch (hour) {
      final h when h >= 5 && h < 12 => Strings.goodMorning,
      final h when h >= 12 && h < 18 => Strings.goodAfternoon,
      final h when h >= 18 => Strings.goodEvening,
      _ => Strings.goodMorning,
    };
  }
}

extension BoolExtensions on bool {
  Tween<double> tween(double begin, double end) {
    return Tween<double>(begin: this ? begin : end, end: this ? end : begin);
  }

  T useValue<T>(T first, T second) => this ? first : second;
}

extension DoubleExtensions on num {
  RoundedRectangleBorder modalShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(toDouble())),
    );
  }

  EdgeInsets get paddingAll => EdgeInsets.all(toDouble());
  BorderRadius get radius => BorderRadius.circular(toDouble());
}

extension ContextExtensions on BuildContext {
  double get viewInsetsBottom => MediaQuery.of(this).viewInsets.bottom;
  EdgeInsets get bottomPadding => EdgeInsets.only(bottom: viewInsetsBottom);
}

extension CategoriesExtensions on Categories {
  List<ExercisesByDay> group() {
    final allExercises = expand((e) => e.exercises).toList();
    final groupedByDay = <int, Exercises>{};

    for (final exercise in allExercises) {
      if (groupedByDay[exercise.day] == null) {
        groupedByDay[exercise.day] = [];
      }
      groupedByDay[exercise.day]!.add(exercise);
    }

    return groupedByDay.entries.map(ExercisesByDay.group).toList();
  }

  Categories search(String search) {
    if (search.isEmpty) return this;

    return map(
      (c) => Category(
        id: c.id,
        name: c.name,
        photo: c.photo,
        exercises: c.exercises.search(search),
      ),
    ).where((c) => c.exercises.isNotEmpty).toList();
  }
}

extension ExercisesExtensions on Exercises {
  Exercises search(String search) {
    if (search.isEmpty) return this;

    return where(
      (it) => it.name.toLowerCase().contains(search.toLowerCase()),
    ).toList();
  }
}
