import 'package:flutter/material.dart';

class Spacing extends StatelessWidget {
  final Axis axis;
  final double value;

  const Spacing.vertical(this.value, {super.key}) : axis = Axis.vertical;

  const Spacing.horizontal(this.value, {super.key}) : axis = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return switch (axis) {
      Axis.vertical => SizedBox(height: value),
      Axis.horizontal => SizedBox(width: value),
    };
  }
}
