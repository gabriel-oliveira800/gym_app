import '../entities/index.dart';

abstract class IDataSource {
  Future<void> createCategory({
    required String name,
    required Photo photo,
  });

  Future<Categories> getAllCategories();

  Future<void> createExercise({
    required int day,
    required int sets,
    required int reps,
    required String name,
    required String categoryId,
  });

  Future<Exercises> getAllExercises();
  Future<Exercises> getByCategoryId(String categoryId);
}
