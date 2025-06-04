import 'index.dart';

typedef ExercisesBy = List<ExerciseByWeekday>;

class ExerciseByWeekday {
  final int weekday;
  final Exercises exercises;
  const ExerciseByWeekday(this.weekday, this.exercises);

  ExerciseByWeekday.entry(
    MapEntry<int, Exercises> data,
  ) : this(data.key, data.value);
}
