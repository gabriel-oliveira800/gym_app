import 'package:flutter/material.dart';

import '../../core/entities/index.dart';
import '../components/index.dart';
import '../../shared/index.dart';

import 'components/index.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _controller;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _controller = HomeController()..onLoad();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        search: _searchController,
      ),
      floatingActionButton: _facActionButton(),
      body: AnimatedBuilder(
        animation: _controller.categories,
        builder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _body(),
        ),
      ),
    );
  }

  Widget _categoriesOrDayOfWeek(Categories categories) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _controller.type,
        _controller.selectedWeekday,
        _controller.selectedCategory,
      ]),
      builder: (_, __) => CategoriesGroup(
        categories: categories,
        type: _controller.type.value,
        onTypeChanged: _controller.setType,
        onChanged: _controller.setSelectedCategory,
        selected: _controller.selectedCategory.value,
        onChangedWeekday: _controller.setSelectedWeekday,
        selectedWeekday: _controller.selectedWeekday.value,
      ),
    );
  }

  Widget _body() {
    if (_controller.categories.value.isEmpty) {
      return const EmptyData();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacing.vertical(18),
        _categoriesOrDayOfWeek(_controller.categories.value),
        const Spacing.vertical(24),
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: switch (_controller.type.value) {
                CategoriaType.grouped => _groupedContent(
                    _controller.categories.value,
                  ),
                CategoriaType.list => _listContent(
                    _controller.categories.value,
                  ),
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _groupedContent(Categories categories) {
    return AnimatedBuilder(
      animation: _searchController,
      builder: (_, __) {
        final filtered = categories.search(_searchController.text);

        return ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: filtered.length,
          separatorBuilder: (_, __) => const Spacing.vertical(8),
          itemBuilder: (_, index) => TrainingCardGrouped(
            category: filtered[index],
            onPressed: _controller.setSelectedCategory,
          ),
        );
      },
    );
  }

  Widget _listContent(Categories categories) {
    return TrainingCardByDay(
      exercises: categories.group(),
    );
  }

  Widget _facActionButton() {
    return FabActionsButton(
      onCategory: () async {
        final category = await AddCategoryContent.show(context);
        if (category != null) await AddExerciseContent.show(context);
      },
      onExercise: () async {
        await AddExerciseContent.show(context);
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
