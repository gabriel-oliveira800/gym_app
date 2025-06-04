import 'package:flutter/material.dart';

import '../../../shared/states/index.dart';
import '../../../core/entities/index.dart';
import '../../components/index.dart';
import '../../../shared/index.dart';
import '../home_controller.dart';

class CategoriesGroup extends StatelessWidget {
  final Categories categories;
  final HomeController controller;

  const CategoriesGroup({
    super.key,
    required this.categories,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.dayOfWeek,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const Spacing.vertical(12),
        SizedBox(
          height: 40,
          child: _weekDayList(),
        ),
      ],
    );
  }

  Widget _weekDayList() {
    return StateOfBuilder(
      state: controller.weekdays,
      builder: (weekdays) => WeekDayList(
        selected: weekdays,
        maxHeight: double.infinity,
        onChanged: controller.weekdays.add,
      ),
    );
  }
}
