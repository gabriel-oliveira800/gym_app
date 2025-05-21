import 'dart:developer';

import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

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
  Future<void> createCategory({
    required String name,
    required Photo photo,
  }) async {
    try {
      final category = Category(
        name: name,
        photo: photo,
        id: const Uuid().v4(),
      );

      _isar.writeTxnSync(() {
        _isar.categoryDtos.putSync(CategoryDto.by(category));
      });
    } catch (e) {
      log('Error creating category: $e');
    }
  }

  @override
  Future<Categories> getAllCategories() async {
    try {
      final categories = await _isar.categoryDtos.where().findAll();
      if (categories.isEmpty) return [];

      return await Future.wait(
        categories.map((it) async {
          return Category(
            id: it.id,
            name: it.name,
            exercises: await getByCategoryId(it.id),
            photo: switch (it.photo.type) {
              1 => NetworkPhoto(it.photo.source),
              _ => AssetPhoto(it.photo.source, id: it.photo.id),
            },
          );
        }),
      );
    } catch (e) {
      log('Error fetching categories: $e');
      return [];
    }
  }

  @override
  Future<void> createExercise({
    required int day,
    required int sets,
    required int reps,
    required String name,
    required String categoryId,
  }) async {
    try {
      final exercise = Exercise(
        day: day,
        sets: sets,
        reps: reps,
        name: name,
        categoryId: categoryId,
        id: const Uuid().v4(),
      );

      _isar.writeTxnSync(() {
        _isar.exerciseDtos.putSync(ExerciseDto.by(exercise));
      });
    } catch (e) {
      log('Error: $e');
    }
  }

  @override
  Future<Exercises> getAllExercises() async {
    try {
      final data = await _isar.exerciseDtos.where().findAll();
      if (data.isEmpty) return [];

      return data.map((dto) {
        return Exercise(
          id: dto.id,
          day: dto.day,
          sets: dto.sets,
          name: dto.name,
          reps: dto.reps,
          categoryId: dto.categoryId,
        );
      }).toList();
    } catch (e) {
      log('Error: $e');
      return [];
    }
  }

  @override
  Future<Exercises> getByCategoryId(String categoryId) async {
    try {
      final data = await _isar.exerciseDtos
          .filter()
          .categoryIdEqualTo(categoryId)
          .findAll();

      if (data.isEmpty) return [];

      return data.map((dto) {
        return Exercise(
          id: dto.id,
          day: dto.day,
          sets: dto.sets,
          name: dto.name,
          reps: dto.reps,
          categoryId: dto.categoryId,
        );
      }).toList();
    } catch (e) {
      log('Error: $e');
      return [];
    }
  }
}
