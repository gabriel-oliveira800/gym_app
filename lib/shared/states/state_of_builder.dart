import 'package:flutter/material.dart';

import 'state_of.dart';

typedef BuilderState<T> = Widget Function(T value);

class StateOfBuilder<T> extends StatelessWidget {
  final StateOf<T> state;
  final BuilderState<T> builder;

  const StateOfBuilder({
    super.key,
    required this.builder,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: state,
      builder: (context, child) => builder(state.value),
    );
  }
}

typedef MultiBuilderState<T, R> = Widget Function(T value, R other);

class MultiStateOfBuilder<T, R> extends StatelessWidget {
  final List<StateOf> states;
  final MultiBuilderState builder;

  MultiStateOfBuilder({
    super.key,
    required this.states,
    required this.builder,
  }) : assert(
          states.isNotEmpty && states.length == 2,
          'MultiStateOfBuilder requires at least two states.',
        );

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge(states),
      builder: (_, __) => builder(
        states.first.value as T,
        states.last.value as R,
      ),
    );
  }
}
