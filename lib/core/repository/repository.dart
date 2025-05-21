import '../entities/index.dart';
import 'data_source.dart';

class Repository {
  final IDataSource _dataSource;
  const Repository(this._dataSource);

  Future<void> createCategory({
    required String name,
    required Photo photo,
  }) async {
    return await _dataSource.createCategory(
      name: name,
      photo: photo,
    );
  }

  Future<void> createExercise({
    required int day,
    required int sets,
    required int reps,
    required String name,
    required String categoryId,
  }) async {
    return await _dataSource.createExercise(
      day: day,
      sets: sets,
      reps: reps,
      name: name,
      categoryId: categoryId,
    );
  }

  Future<Categories> getAllCategories() async {
    return await _dataSource.getAllCategories();
  }

  Future<Exercises> getAllExercises() async {
    return await _dataSource.getAllExercises();
  }

  Future<Exercises> getByCategoryId(String categoryId) async {
    return await _dataSource.getByCategoryId(categoryId);
  }
}
