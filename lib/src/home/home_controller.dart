import '../../core/repository/index.dart';
import '../../core/index.dart';

import '../../shared/states/index.dart';
import '../../shared/utils.dart';

class HomeController {
  final Repository repository;
  HomeController(this.repository);

  final selectedCategory = StateOf<Category?>(null);
  final weekdays = ListStateOf<int>.first(Utils.getWeekday());

  final categories = ListStateOf<Category>([]);
  final exercises = ListStateOf<ExerciseByWeekday>([]);

  Future<void> onLoad() async {
    categories.update(await repository.getAllCategories());
    exercises.update(await repository.getAllExercises());
  }
}
