import '../entities/index.dart';
import 'data_source.dart';

class Repository {
  final IDataSource _dataSource;
  const Repository(this._dataSource);

  Future<Category?> createCategory({
    required String name,
    required Photo photo,
  }) async {
    return await _dataSource.createCategory(
      name: name,
      photo: photo,
    );
  }

  Future<Exercise?> createExercise({
    required String name,
    required List<int> days,
    required MapEntry<int, int> max,
    required List<String> categories,
  }) async {
    return await _dataSource.createExercise(
      max: max,
      days: days,
      name: name,
      categories: categories,
    );
  }

  Future<Categories> getAllCategories() async {
    return await _dataSource.getAllCategories();
  }

  Future<ExercisesBy> getAllExercises() async {
    return await _dataSource.getAllExercises();
  }
}
