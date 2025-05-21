import 'package:flutter/widgets.dart';

import '../../core/index.dart';
import '../../core/repository/index.dart';
import 'components/index.dart';

class HomeController {
  final Repository repository;
  HomeController(this.repository);

  final type = ValueNotifier<CategoriaType>(CategoriaType.list);
  void setType(CategoriaType value) => type.value = value;

  final selectedWeekday = ValueNotifier<int?>(null);
  void setSelectedWeekday(int? value) => selectedWeekday.value = value;

  final selectedCategory = ValueNotifier<Category?>(null);
  void setSelectedCategory(Category? value) => selectedCategory.value = value;

  final categories = ValueNotifier<Categories>([]);

  Future<void> onLoad() async {
    categories.value = await repository.getAllCategories();
  }

  Future<void> createExercise({
    required int day,
    required int sets,
    required int reps,
    required String name,
    required String categoryId,
  }) async {
    await repository.createExercise(
      day: day,
      sets: sets,
      reps: reps,
      name: name,
      categoryId: categoryId,
    );

    await onLoad();
  }

  Future<void> createCategory({
    required String name,
    required Photo photo,
  }) async {
    await repository.createCategory(name: name, photo: photo);
    await onLoad();
  }
}
