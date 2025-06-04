typedef Exercises = List<Exercise>;

class Exercise {
  final String id;
  final int series;
  final String name;
  final int repetitions;

  final List<int> days;
  final List<String> categories;

  const Exercise({
    required this.id,
    required this.days,
    required this.name,
    required this.series,
    required this.categories,
    required this.repetitions,
  });

  bool get isMaxRep => repetitions < 0;
  String qntReps() => repetitions < 0 ? 'MAX' : repetitions.toString();

  bool get isMaxSet => series < 0;
  String qntSets() => series < 0 ? 'MAX' : series.toString();
}

// class ExercisesByDay {
//   final int day;
//   final Exercises exercises;

//   const ExercisesByDay({
//     required this.day,
//     required this.exercises,
//   });

//   factory ExercisesByDay.group(MapEntry<int, List<Exercise>> data) {
//     return ExercisesByDay(day: data.key, exercises: data.value);
//   }

//   @override
//   String toString() {
//     return 'ExercisesByDay(day: $day, exercises: $exercises)';
//   }
// }
