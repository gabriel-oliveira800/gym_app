import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../../core/entities/index.dart';

import '../../../shared/index.dart';
import '../../components/index.dart';

import 'avatar.dart';

class TrainingCardGrouped extends StatefulWidget {
  final Category category;
  final ValueChanged<Category> onPressed;

  const TrainingCardGrouped({
    super.key,
    required this.category,
    required this.onPressed,
  });

  @override
  State<TrainingCardGrouped> createState() => _TrainingCardGroupedState();
}

class _TrainingCardGroupedState extends State<TrainingCardGrouped> {
  bool _isExpanded = false;
  void _toggle() => setState(() => _isExpanded = !_isExpanded);

  @override
  void initState() {
    super.initState();
    ThemeNotifier().mode.addListener(_updateColors);
  }

  void _updateColors() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggle,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ThemeNotifier.borderColorByMode()),
        ),
        child: Column(
          children: [
            _header(),
            Visibility(
              visible: _isExpanded,
              child: _table(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        CategoryAvatar(
          photo: widget.category.photo,
        ),
        const Spacing.horizontal(16),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.category.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: ThemeNotifier.textColorByMode(),
              ),
            ),
            Text(
              Strings.qntExercises(widget.category.exercises.length),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ThemeNotifier.textColorByMode(),
              ),
            ),
          ],
        ),
        const Spacer(),
        SvgPicture.asset(
          width: 30,
          height: 30,
          _isExpanded ? Svgs.chevronUp : Svgs.chevronDown,
          colorFilter: ColorFilter.mode(
            ThemeNotifier.whiteOrBlackColor(),
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }

  Widget _table() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(
            height: 1,
            color: Color(0xFFBDBDBD),
          ),
        ),
        Table(
          columnWidths: {
            0: const FlexColumnWidth(3),
            1: const FlexColumnWidth(1.5),
            2: const FlexColumnWidth(1.5),
            3: const FlexColumnWidth(2),
          },
          border: TableBorder(
            horizontalInside: BorderSide(
              width: 0.5,
              color: Colors.grey.shade700,
            ),
          ),
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withValues(alpha: 0.1),
              ),
              children: Strings.trainingLabels
                  .map((it) => _tableContent(it, FontWeight.bold))
                  .toList(),
            ),
            ...widget.category.exercises.map(
              (it) => TableRow(
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surface
                      .withValues(alpha: 0.05),
                ),
                children: [
                  _tableContent(it.name),
                  _tableContent(it.sets.toString()),
                  _tableContent(it.reps.toString()),
                  _tableContent(
                    Strings
                        .shortWeekdays[DateTime(2020, 1, it.day).weekday - 1],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _tableContent(
    String text, [
    FontWeight fontWeight = FontWeight.w400,
  ]) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(fontWeight: fontWeight),
      ),
    );
  }

  @override
  void dispose() {
    ThemeNotifier().mode.removeListener(_updateColors);
    super.dispose();
  }
}
