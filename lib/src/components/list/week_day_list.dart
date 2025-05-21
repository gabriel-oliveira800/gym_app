import 'package:flutter/material.dart';

import '../../../shared/strings.dart';
import '../spacing.dart';
import 'list_item.dart';

class WeekDayList extends StatelessWidget {
  final bool isWrap;
  final double spacing;

  final int? selected;
  final double? maxHeight;
  final ListItemStyle itemStyle;
  final ValueChanged<int>? onChanged;

  const WeekDayList({
    super.key,
    this.selected,
    this.onChanged,
    this.maxHeight,
    this.isWrap = false,
    this.spacing = 8,
    this.itemStyle = const ListItemStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxHeight,
      child: isWrap ? _contentWrap() : _contentList(),
    );
  }

  Widget _contentList() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: DateTime.daysPerWeek,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) => const Spacing.horizontal(8),
      itemBuilder: (_, index) {
        final data = Strings.shortWeekdays[index];

        return ListItem(
          style: itemStyle,
          name: data[0].toUpperCase(),
          isSelected: index == selected,
          onTap: () => onChanged?.call(index),
        );
      },
    );
  }

  Widget _contentWrap() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final spacingRemove = (DateTime.daysPerWeek - 1) * spacing;
        final minItemWidth =
            (constraints.maxWidth - spacingRemove) / DateTime.daysPerWeek;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(
            DateTime.daysPerWeek,
            (index) {
              final data = Strings.shortWeekdays[index];

              return Container(
                width: minItemWidth,
                alignment: Alignment.center,
                child: ListItem(
                  style: itemStyle,
                  name: data[0].toUpperCase(),
                  isSelected: index == selected,
                  onTap: () => onChanged?.call(index),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
