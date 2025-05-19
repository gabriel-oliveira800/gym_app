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
