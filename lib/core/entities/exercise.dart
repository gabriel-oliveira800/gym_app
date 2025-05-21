typedef Exercises = List<Exercise>;

class Exercise {
  final int day;
  final int reps;
  final int sets;
  final String id;
  final String name;
  final String categoryId;

  const Exercise({
    required this.id,
    required this.day,
    required this.reps,
    required this.sets,
    required this.name,
    required this.categoryId,
  });

  bool get isMaxRep => reps < 0;
  String qntReps() => reps < 0 ? 'MAX' : reps.toString();

  bool get isMaxSet => sets < 0;
  String qntSets() => sets < 0 ? 'MAX' : sets.toString();

  @override
  String toString() {
    return 'Exercise(day: $day, reps: $reps, sets: $sets, id: $id, name: $name, categoryId: $categoryId)';
  }
}

class ExercisesByDay {
  final int day;
  final Exercises exercises;

  const ExercisesByDay({
    required this.day,
    required this.exercises,
  });

  factory ExercisesByDay.group(MapEntry<int, List<Exercise>> data) {
    return ExercisesByDay(day: data.key, exercises: data.value);
  }

  @override
  String toString() {
    return 'ExercisesByDay(day: $day, exercises: $exercises)';
  }
}
