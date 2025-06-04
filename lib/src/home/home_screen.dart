import 'package:flutter/material.dart';

import '../../core/entities/index.dart';
import '../../main.dart';
import '../../shared/index.dart';
import '../../shared/states/index.dart';
import '../components/index.dart';
import 'components/index.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController(repository)..onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        controller: _controller,
      ),
      floatingActionButton: _facActionButton(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StateOfBuilder(
          state: _controller.categories,
          builder: (categories) => CategoriesGroup(
            categories: categories,
            controller: _controller,
          ),
        ),
        const Spacing.vertical(24),
        MultiStateOfBuilder<ExercisesBy, List<int>>(
          states: [_controller.exercises, _controller.weekdays],
          builder: (exercises, weekdays) => _content(exercises, weekdays),
        ),
      ],
    );
  }

  Widget _content(ExercisesBy data, List<int> weekdays) {
    return Expanded(
      child: GroupedExerciseByWeekday(
        exercises: data.filterByWeekdays(weekdays),
      ),
    );
  }

  Widget _facActionButton() {
    return FabActionsButton(
      onExercise: _createExercise,
      onCategory: _createCategory,
    );
  }

  void _createCategory() async {
    final result = await AddCategoryContent.show(
      context,
      controller: _controller,
    );

    if (result != null) await _controller.onLoad();
  }

  void _createExercise() async {
    final result = await AddExerciseContent.show(
      context,
      categories: _controller.categories.value,
    );

    if (result != null) await _controller.onLoad();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }
}
