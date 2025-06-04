import 'package:flutter/material.dart';

import '../../../core/index.dart';
import '../../components/index.dart';

class CategoriesList extends StatelessWidget {
  final Categories selected;
  final Categories categories;
  final ListItemStyle itemStyle;
  final ValueChanged<Category>? onChanged;

  const CategoriesList({
    super.key,
    this.onChanged,
    required this.selected,
    required this.categories,
    this.itemStyle = const ListItemStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: categories.length,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) => const Spacing.horizontal(8),
      itemBuilder: (_, index) {
        final category = categories[index];
        return ListItem(
          style: itemStyle,
          name: category.name,
          onTap: () => onChanged?.call(category),
          isSelected: selected.contains(category),
        );
      },
    );
  }
}
