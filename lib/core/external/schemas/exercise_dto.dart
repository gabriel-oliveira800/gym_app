import 'package:isar/isar.dart';

import '../../index.dart';
import 'schema_utils.dart';

part 'exercise_dto.g.dart';

@collection
class ExerciseDto {
  Id get isarId => fastHash(id);

  late String id;
  late String categoryId;

  late int day;
  late int reps;
  late int sets;
  late String name;

  ExerciseDto();

  factory ExerciseDto.by(Exercise exercise) {
    return ExerciseDto()
      ..id = exercise.id
      ..day = exercise.day
      ..reps = exercise.reps
      ..sets = exercise.sets
      ..name = exercise.name
      ..categoryId = exercise.categoryId;
  }
}
