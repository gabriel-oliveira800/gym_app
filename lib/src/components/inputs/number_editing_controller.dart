import 'package:flutter/material.dart';

class NumberEditingController extends TextEditingController {
  NumberEditingController({
    int value = 0,
  }) : super(text: value.toString());

  static const _max = 'MAX';
  bool get isMax => text == _max;

  int get qnt {
    if (text == _max) return -1;
    return _parse(text);
  }

  void setValue(String value) => text = value;
  int _parse(String value) => int.tryParse(value) ?? 0;

  void decrement() {
    if (isMax) return;

    final value = _parse(text) - 1;
    if (value < 0) return setValue(_max);
    setValue(value.toString());
  }

  void increment() {
    if (isMax) return setValue('0');
    setValue((_parse(text) + 1).toString());
  }
}
