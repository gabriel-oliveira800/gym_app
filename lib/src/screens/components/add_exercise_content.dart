import 'package:flutter/material.dart';
import 'package:faker/faker.dart' as t;

import '../../components/index.dart';
import '../../../shared/index.dart';
import '../../../core/index.dart';

class AddExerciseContent extends StatefulWidget {
  const AddExerciseContent({super.key});

  @override
  State<AddExerciseContent> createState() => _AddExerciseContentState();

  static Future<Exercise?> show(BuildContext context) async {
    return await showModalBottomSheet<Exercise?>(
      context: context,
      shape: 16.modalShape(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddExerciseContent(),
    );
  }
}

class _AddExerciseContentState extends State<AddExerciseContent> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final NumberEditingController _repsController;
  late final NumberEditingController _setsController;

  final _selectedDate = ValueNotifier(DateTime.now().weekday);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _repsController = NumberEditingController();
    _setsController = NumberEditingController();
  }

  void _onSubmitButton() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ThemeWrapper(
        builder: (_, __) => Container(
          padding: context.bottomPadding,
          decoration: BoxDecoration(
            borderRadius: 16.radius,
            color: AppColors.modalAdaptiveColor,
          ),
          child: Padding(
            padding: 16.paddingAll,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Strings.newExercise,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ThemeNotifier.whiteOrBlackColor(),
                    ),
                  ),
                  const Spacing.vertical(32),
                  _dropdownButton(),
                  const Spacing.vertical(32),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: Strings.exerciseNameHint,
                    ),
                  ),
                  const Spacing.vertical(8),
                  _seriesAndRepetitions(),
                  const Spacing.vertical(32),
                  _dayOfWeek(),
                  const Spacing.vertical(48),
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _nameController,
                      _repsController,
                      _setsController,
                      _selectedDate,
                    ]),
                    builder: (_, __) => _submitButton(),
                  ),
                  const Spacing.vertical(24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _seriesAndRepetitions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AddMoreInput(
            hint: Strings.repsHint,
            controller: _repsController,
          ),
        ),
        const Spacing.horizontal(8),
        Expanded(
          child: AddMoreInput(
            hint: Strings.setsHint,
            controller: _setsController,
          ),
        ),
      ],
    );
  }

  Widget _dayOfWeek() {
    return AnimatedBuilder(
      animation: _selectedDate,
      builder: (_, __) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.dayOfWeek,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ThemeNotifier.whiteOrBlackColor(),
            ),
          ),
          const Spacing.vertical(8),
          SizedBox(
            width: double.infinity,
            child: WeekDayList(
              isWrap: true,
              maxHeight: 40,
              selected: _selectedDate.value,
              onChanged: (value) => _selectedDate.value = value,
              itemStyle: const ListItemStyle(radius: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _onSubmitButton,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromHeight(48),
          backgroundColor: ThemeNotifier.whiteOrBlackColor(),
          foregroundColor: ThemeNotifier.blackOrWhiteColor(),
        ),
        child: const Text(
          Strings.createExercise,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Category? _selectedCategory;

  List<Category> categories = [
    Category(
      id: t.faker.guid.guid(),
      name: "Peito",
      photo: Images.all.first,
      exercises: [
        const Exercise(name: "Tríceps Testa", reps: 10, sets: 3, day: 1),
        const Exercise(name: "Tríceps Pulley", reps: 12, sets: 4, day: 2),
      ],
    ),
    Category(
      id: t.faker.guid.guid(),
      name: 'Triceps',
      photo: Images.all.first,
      exercises: [
        const Exercise(name: "Tríceps Testa", reps: 10, sets: 3, day: 1),
        const Exercise(name: "Tríceps Pulley", reps: 12, sets: 4, day: 2),
      ],
    ),
    Category(
      photo: Images.all.first,
      id: t.faker.guid.guid(),
      name: 'Bíceps',
      exercises: [
        const Exercise(name: "Tríceps Testa", reps: 10, sets: 3, day: 1),
        const Exercise(name: "Tríceps Pulley", reps: 12, sets: 4, day: 2),
      ],
    ),
  ];

  Widget _dropdownButton() {
    return DropdownButtonFormField<Category>(
      value: _selectedCategory,
      items: categories
          .map(
            (c) => DropdownMenuItem(
              value: c,
              child: Text(
                c.name,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          )
          .toList(),
      onChanged: (value) => setState(() => _selectedCategory = value),
      validator: (_) {
        if (_selectedCategory == null) {
          return 'Selecione uma categoria';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Categoria',
      ),
    );
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();

    _selectedDate.dispose();

    _nameController.dispose();
    _repsController.dispose();
    _setsController.dispose();

    super.dispose();
  }
}
