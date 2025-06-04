import 'package:flutter/material.dart';

typedef Builder = Widget Function(double maxConstraints);

enum BuilderType { height, width }

class WidthBuilder extends StatelessWidget {
  final double spacing;
  final Builder builder;
  final BuilderType type;

  const WidthBuilder({
    super.key,
    this.spacing = 0.0,
    required this.builder,
    this.type = BuilderType.width,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxValues = switch (type) {
          BuilderType.width => constraints.maxWidth,
          BuilderType.height => constraints.maxHeight,
        };

        return builder(maxValues - spacing);
      },
    );
  }
}
