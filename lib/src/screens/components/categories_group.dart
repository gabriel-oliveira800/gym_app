import 'package:flutter/material.dart';

import '../../../core/entities/index.dart';
import '../../components/index.dart';
import '../../../shared/index.dart';

enum CategoriaType {
  grouped,
  single;

  bool get isGrouped => this == CategoriaType.grouped;
}

class CategoriesGroup extends StatelessWidget {
  final CategoriaType type;
  final ValueChanged<CategoriaType> onTypeChanged;

  final Category? selected;
  final Categories categories;
  final ValueChanged<Category>? onChanged;

  final int? selectedWeekday;
  final ValueChanged<int>? onChangedWeekday;

  const CategoriesGroup({
    super.key,
    this.selected,
    this.onChanged,
    this.selectedWeekday,
    this.onChangedWeekday,
    required this.categories,
    required this.onTypeChanged,
    this.type = CategoriaType.single,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.categories,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const Spacing.vertical(12),
        SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: type.isGrouped ? _categoriesList() : _weekDayList(),
                ),
              ),
              const Spacing.horizontal(8),
              ThemeWrapper(
                builder: (_, __) => Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: ThemeNotifier().colorByMode(
                      AppColors.categoryBgActive,
                      AppColors.categoryBgDisable,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () => onTypeChanged(
                      type.isGrouped
                          ? CategoriaType.single
                          : CategoriaType.grouped,
                    ),
                    icon: Icon(
                      switch (type) {
                        CategoriaType.grouped => Icons.grid_view,
                        CategoriaType.single => Icons.list,
                      },
                    ),
                    color: ThemeNotifier().colorByMode(
                      AppColors.categoryBgDisable,
                      AppColors.categoryBgActive,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoriesList() {
    return Align(
      alignment: Alignment.centerLeft,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const Spacing.horizontal(8),
        itemBuilder: (_, index) {
          final category = categories[index];
          return ListItem(
            name: category.name,
            onTap: () => onChanged?.call(category),
            isSelected: selected?.id == category.id,
          );
        },
      ),
    );
  }

  Widget _weekDayList() {
    return WeekDayList(
      selected: selectedWeekday,
      onChanged: onChangedWeekday,
    );
  }
}
