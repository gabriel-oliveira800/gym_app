typedef Exercises = List<Exercise>;

class Exercise {
  final int day;
  final int reps;
  final int sets;
  final String name;

  const Exercise({
    required this.day,
    required this.reps,
    required this.sets,
    required this.name,
  });

  @override
  String toString() {
    return 'Exercise(day: $day, reps: $reps, sets: $sets, name: $name)';
  }
}
