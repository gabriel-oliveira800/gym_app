import 'package:flutter/material.dart';

import '../../../../shared/states/index.dart';
import '../../../components/index.dart';
import '../../../../shared/index.dart';
import '../../../../core/index.dart';
import '../index.dart';

class AddExerciseContent extends StatefulWidget {
  final Categories categories;

  const AddExerciseContent({
    super.key,
    required this.categories,
  });

  @override
  State<AddExerciseContent> createState() => _AddExerciseContentState();

  static Future<Exercise?> show(
    BuildContext context, {
    required Categories categories,
  }) async {
    return await showModalBottomSheet<Exercise?>(
      context: context,
      shape: 16.modalShape(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddExerciseContent(categories: categories),
    );
  }
}

class _AddExerciseContentState extends State<AddExerciseContent> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final NumberEditingController _repsController;
  late final NumberEditingController _seriesController;

  late final AddExerciseController _controller;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _repsController = NumberEditingController();
    _seriesController = NumberEditingController();

    _controller = AddExerciseController();
  }

  void _onSubmitButton() async {
    if (!_formKey.currentState!.validate()) return;

    await _controller.create(
      _nameController.text.trim(),
      series: _seriesController.qnt,
      repetitions: _repsController.qnt,
      onCreated: Navigator.of(context).pop,
    );
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
                  AnimatedBuilder(
                    animation: _controller.categories,
                    builder: (_, __) => _categories(),
                  ),
                  const Spacing.vertical(32),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: Strings.exerciseNameHint,
                    ),
                  ),
                  const Spacing.vertical(12),
                  _seriesAndRepetitions(),
                  const Spacing.vertical(32),
                  _dayOfWeek(),
                  const Spacing.vertical(48),
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _nameController,
                      _repsController,
                      _seriesController,
                      _controller.weekdays,
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

  Widget _categories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Strings.categories,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const Spacing.vertical(8),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: StateOfBuilder(
            state: _controller.categories,
            builder: (categories) => CategoriesList(
              selected: categories,
              categories: widget.categories,
              onChanged: _controller.categories.add,
              itemStyle: const ListItemStyle(radius: 8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _seriesAndRepetitions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.setsHint,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeNotifier.whiteOrBlackColor(),
                ),
              ),
              const Spacing.vertical(8),
              AddMoreInput(
                controller: _seriesController,
              ),
            ],
          ),
        ),
        const Spacing.horizontal(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.repsHint,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeNotifier.whiteOrBlackColor(),
                ),
              ),
              const Spacing.vertical(8),
              AddMoreInput(
                controller: _repsController,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dayOfWeek() {
    return Column(
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
        StateOfBuilder(
          state: _controller.weekdays,
          builder: (value) => WeekDayList(
            isWrap: true,
            maxHeight: 40,
            selected: value,
            onChanged: _controller.weekdays.add,
            itemStyle: const ListItemStyle(
              radius: 8,
              padding: EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _submitButton() {
    final isEnabled = _nameController.isNotEmpty &&
        !_repsController.isZero &&
        !_seriesController.isZero &&
        !_controller.categories.isEmpty;

    return Button(
      isEnabled: isEnabled,
      onPressed: _onSubmitButton,
      text: Strings.createExercise,
      inLoading: _controller.isLoading,
    );
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _controller.dispose();

    _nameController.dispose();
    _repsController.dispose();
    _seriesController.dispose();

    super.dispose();
  }
}
