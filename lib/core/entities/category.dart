import 'exercise.dart';
import 'photo.dart';

typedef Categories = List<Category>;

class Category {
  final String id;
  final String name;
  final Photo photo;
  final Exercises exercises;

  const Category({
    required this.id,
    required this.name,
    required this.photo,
    this.exercises = const <Exercise>[],
  });

  @override
  String toString() {
    return 'Category(id: $id, name: $name, photo: $photo, exercises: $exercises)';
  }
}
