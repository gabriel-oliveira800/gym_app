import 'package:flutter/widgets.dart';

import '../../core/index.dart';
import 'components/index.dart';

class HomeController {
  final type = ValueNotifier<CategoriaType>(CategoriaType.list);
  void setType(CategoriaType value) => type.value = value;

  final selectedWeekday = ValueNotifier<int?>(DateTime.now().weekday);
  void setSelectedWeekday(int? value) => selectedWeekday.value = value;

  final selectedCategory = ValueNotifier<Category?>(null);
  void setSelectedCategory(Category? value) => selectedCategory.value = value;

  final categories = ValueNotifier<Categories>([]);

  Future<void> onLoad() async {}
}
