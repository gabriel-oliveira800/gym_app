import 'package:flutter/material.dart';

class StateOf<T> with ChangeNotifier {
  T value;
  StateOf(this.value);

  void update(T newValue) {
    if (value == newValue) return;
    value = newValue;
    notifyListeners();
  }
}

class BoolState extends StateOf<bool> {
  BoolState(super.value);
  void call() => toggle();
  void toggle() => update(!value);
}

class InLoading extends BoolState {
  InLoading() : super(false);
}

class ListStateOf<T> extends StateOf<List<T>> {
  ListStateOf(super.value);
  ListStateOf.first(T first) : super([first]);

  void copy(T it, [bool isAdd = true]) {
    if (!isAdd) return update(List.from(value)..remove(it));
    update(List.from(value)..add(it));
  }

  void clear() => update([]);
  bool get isEmpty => value.isEmpty;
  bool contains(T it) => value.contains(it);

  void add(T it) => contains(it) ? copy(it, false) : copy(it);
}
