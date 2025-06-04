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

  DateTime day(int newDay) => DateTime(year, month, newDay);
}

extension BoolExtensions on bool {
  Tween<double> tween(double begin, double end) {
    return Tween<double>(begin: this ? begin : end, end: this ? end : begin);
  }

  T useValue<T>(T first, T second) => this ? first : second;
}

extension DoubleExtensions on num {
  Duration get duration => Duration(milliseconds: toInt());

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

extension TextEditingExtensions on TextEditingController {
  bool get isEmpty => text.isEmpty;
  bool get isNotEmpty => text.isNotEmpty;
}

extension StrExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension ExercisesByExtensions on ExercisesBy {
  ExercisesBy filterByWeekdays(List<int> weekdays) {
    if (weekdays.isEmpty) return this;

    sort((a, b) => a.weekday.compareTo(b.weekday));
    return where((it) => weekdays.contains(it.weekday)).toList();
  }
}
