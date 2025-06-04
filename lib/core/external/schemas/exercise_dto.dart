import 'package:isar/isar.dart';

import '../../index.dart';
import 'schema_utils.dart';

part 'exercise_dto.g.dart';

@collection
class ExerciseDto {
  Id get isarId => fastHash(id);

  late String id;
  late String name;

  late int series;
  late int repetitions;

  late List<int> days;
  late List<String> categories;

  ExerciseDto();

  factory ExerciseDto.by(Exercise exercise) {
    return ExerciseDto()
      ..id = exercise.id
      ..name = exercise.name
      ..days = exercise.days
      ..series = exercise.series
      ..categories = exercise.categories
      ..repetitions = exercise.repetitions;
  }

  Exercise toDomain() {
    return Exercise(
      id: id,
      days: days,
      name: name,
      series: series,
      categories: categories,
      repetitions: repetitions,
    );
  }
}
