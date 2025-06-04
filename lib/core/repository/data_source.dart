import '../entities/index.dart';

abstract class IDataSource {
  Future<Category?> createCategory({
    required String name,
    required Photo photo,
  });

  Future<ExercisesBy> getAllExercises();
  Future<Categories> getAllCategories();

  Future<Exercise?> createExercise({
    required String name,
    required List<int> days,
    required MapEntry<int, int> max,
    required List<String> categories,
  });
}
