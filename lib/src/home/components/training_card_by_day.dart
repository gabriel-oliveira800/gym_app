import 'package:flutter/material.dart';
import 'package:gym_app/shared/index.dart';

import '../../../core/entities/index.dart';
import '../../components/index.dart';

class TrainingCardByDay extends StatefulWidget {
  final List<ExercisesByDay> exercises;

  const TrainingCardByDay({
    super.key,
    required this.exercises,
  });

  @override
  State<TrainingCardByDay> createState() => _TrainingCardByDayState();
}

class _TrainingCardByDayState extends State<TrainingCardByDay> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: widget.exercises.length,
      separatorBuilder: (_, __) => const Spacing.vertical(16),
      itemBuilder: (context, index) {
        final data = widget.exercises[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📅 ${Strings.weekdays[data.day]}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacing.vertical(8),
            _wrapper(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  const Divider(),
                  ThemeWrapper(
                    builder: (_, __) => _content(data.exercises),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _wrapper({required Widget child}) {
    return ThemeWrapper(
      builder: (_, __) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
          color: ThemeNotifier.blackOrWhiteColor().withValues(alpha: 0.95),
        ),
        child: child,
      ),
    );
  }

  static const _headerMaxWidth = 64.0;

  Widget _header() {
    final style = const TextStyle(
      fontWeight: FontWeight.bold,
    );

    return Container(
      height: 32.0,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(Strings.trainingLabels[0], style: style),
          ),
          Container(
            width: _headerMaxWidth,
            alignment: Alignment.center,
            child: Text(Strings.trainingLabels[2], style: style),
          ),
          Container(
            width: _headerMaxWidth,
            alignment: Alignment.center,
            child: Text(Strings.trainingLabels[1], style: style),
          ),
        ],
      ),
    );
  }

  Widget _content(Exercises exercises) {
    final style = TextStyle(color: ThemeNotifier.whiteOrBlackColor());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: exercises
          .map(
            (it) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(it.name, style: style),
                  ),
                  Container(
                    width: _headerMaxWidth,
                    alignment: Alignment.center,
                    child: Text(
                      it.qntReps(),
                      style: style.copyWith(
                        fontWeight: it.isMaxRep.useValue(
                          FontWeight.bold,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: _headerMaxWidth,
                    alignment: Alignment.center,
                    child: Text(
                      it.qntSets(),
                      style: style.copyWith(
                        fontWeight: it.isMaxSet.useValue(
                          FontWeight.bold,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
