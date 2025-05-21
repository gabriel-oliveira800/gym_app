import 'package:flutter/material.dart';

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
