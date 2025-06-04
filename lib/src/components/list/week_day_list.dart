import 'package:flutter/material.dart';

import '../../../shared/utils.dart';
import '../index.dart';

class WeekDayList extends StatelessWidget {
  final bool isWrap;
  final double spacing;

  final double maxHeight;
  final List<int> selected;
  final ListItemStyle itemStyle;
  final ValueChanged<int>? onChanged;

  const WeekDayList({
    super.key,
    this.onChanged,
    this.spacing = 8,
    this.isWrap = false,
    required this.maxHeight,
    this.selected = const [],
    this.itemStyle = const ListItemStyle(),
  });

  @override
  Widget build(BuildContext context) {
    final data = Utils.getShortWeekdays();

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: isWrap ? _contentWrap(data) : _contentList(data),
      ),
    );
  }

  Widget _contentList(List<String> data) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: data.length,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) => const Spacing.horizontal(8),
      itemBuilder: (_, index) => _item(name: data[index], index: index),
    );
  }

  Widget _contentWrap(List<String> data) {
    return WidthBuilder(
      spacing: DateTime.daysPerWeek * spacing,
      builder: (maxWidth) {
        final constraints = BoxConstraints(
          maxHeight: maxHeight,
          maxWidth: maxWidth / DateTime.daysPerWeek,
        );

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (int i = 0; i < data.length; i++)
              _item(
                index: i,
                name: data[i],
                constraints: constraints,
              ),
          ],
        );
      },
    );
  }

  Widget _item({
    required int index,
    required String name,
    BoxConstraints constraints = const BoxConstraints(maxHeight: 32),
  }) {
    final normalizedIndex = index + 1;
    return ListItem(
      name: name,
      style: itemStyle,
      constraints: constraints,
      onTap: () => onChanged?.call(normalizedIndex),
      isSelected: selected.contains(normalizedIndex),
    );
  }
}
