import 'package:flutter/material.dart';

class MaxAndMinValues {
  final int max;
  final int min;

  const MaxAndMinValues.then() : this(max: 10, min: 10);

  const MaxAndMinValues({
    required this.max,
    required this.min,
  });

  String get minStr => min.toString();
  String get maxStr => max.toString();

  @override
  String toString() => 'MaxAndMinValues(max: $max, min: $min)';
}

class NumberEditingController extends TextEditingController {
  final MaxAndMinValues limits;

  NumberEditingController({
    int value = 0,
    this.limits = const MaxAndMinValues.then(),
  }) : super(text: value.toString());

  static const _max = 'MAX';
  bool get isMax => text == _max;

  bool get isZero => text == '0' || text.isEmpty;

  int get qnt {
    if (text == _max) return -1;
    return _parse(text);
  }

  void setValue(String value) => text = value;
  int _parse(String value) => int.tryParse(value) ?? 0;

  void decrement([String? value, int qnt = 1]) {
    if (isMax) return;

    final parsedValue = _parse(text) - qnt;
    if (parsedValue <= 0) return setValue(_max);
    setValue(parsedValue.toString());
  }

  void increment([String? value, int qnt = 1]) {
    if (isMax) return setValue(value ?? '1');
    setValue((_parse(text) + qnt).toString());
  }

  void longDecrement() => decrement(limits.minStr, limits.min);
  void longIncrement() => increment(limits.maxStr, limits.max);
}
