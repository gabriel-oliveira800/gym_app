import 'exercise.dart';

class Category {
  final String name;
  final Exercises exercises;

  const Category({
    required this.name,
    required this.exercises,
  });

  @override
  String toString() => 'Category(name: $name, exercises: $exercises)';
}
