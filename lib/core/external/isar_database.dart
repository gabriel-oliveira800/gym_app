import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../shared/utils.dart';
import '../repository/index.dart';
import '../entities/index.dart';
import 'schemas/index.dart';

class IsarDatabase implements IDataSource {
  IsarDatabase._internal();
  factory IsarDatabase() => _instance;

  static final _instance = IsarDatabase._internal();

  late final Isar _isar;
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      directory: dir.path,
      [
        ExerciseDtoSchema,
        CategoryDtoSchema,
      ],
    );

    _isInitialized = true;
  }

  @override
  Future<Category?> createCategory({
    required String name,
    required Photo photo,
  }) async {
    try {
      final category = Category(
        name: name,
        photo: photo,
        id: const Uuid().v4(),
      );

      return _isar.writeTxnSync(() {
        _isar.categoryDtos.putSync(CategoryDto.by(category));
        return category;
      });
    } catch (e) {
      Utils.errorToast(e.toString());
      return null;
    }
  }

  @override
  Future<Exercise?> createExercise({
    required String name,
    required List<int> days,
    required MapEntry<int, int> max,
    required List<String> categories,
  }) async {
    try {
      final exercise = Exercise(
        days: days,
        name: name,
        series: max.key,
        categories: categories,
        repetitions: max.value,
        id: const Uuid().v4(),
      );

      return _isar.writeTxnSync(() {
        _isar.exerciseDtos.putSync(ExerciseDto.by(exercise));
        return exercise;
      });
    } catch (e) {
      Utils.errorToast(e.toString());
      return null;
    }
  }

  @override
  Future<Categories> getAllCategories() async {
    try {
      final categories = await _isar.categoryDtos.where().findAll();
      return categories.map((it) => it.toDomain()).toList();
    } catch (e) {
      Utils.errorToast(e.toString());
      return [];
    }
  }

  @override
  Future<ExercisesBy> getAllExercises() async {
    try {
      final all = (await _isar.exerciseDtos.where().findAll())
          .map((it) => it.toDomain())
          .toList();

      final result = <int, Exercises>{};
      final allDay = all.expand((it) => it.days).toSet();

      for (final day in allDay) {
        result.putIfAbsent(day, () => []);
        result[day]!.addAll(all.where((it) => it.days.contains(day)));
      }

      return result.entries.map(ExerciseByWeekday.entry).toList();
    } catch (e) {
      Utils.errorToast(e.toString());
      return [];
    }
  }
}
