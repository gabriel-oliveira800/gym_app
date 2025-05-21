// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../components/index.dart';
import '../../../shared/index.dart';
import '../../../core/index.dart';
import '../home_controller.dart';

class AddExerciseContent extends StatefulWidget {
  final HomeController controller;

  const AddExerciseContent({
    super.key,
    required this.controller,
  });

  @override
  State<AddExerciseContent> createState() => _AddExerciseContentState();

  static Future<Exercise?> show(
    BuildContext context, {
    required HomeController controller,
  }) async {
    return await showModalBottomSheet<Exercise?>(
      context: context,
      shape: 16.modalShape(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddExerciseContent(controller: controller),
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

  Category? _selectedCategory;
  void onChanged(Category? value) {
    setState(() => _selectedCategory = value);
  }

  bool _isLoading = false;
  void _setLoading() => setState(() => _isLoading = !_isLoading);

  void _onSubmitButton() async {
    if (!_formKey.currentState!.validate() || _selectedCategory == null) return;

    _setLoading();

    await widget.controller.createExercise(
      day: _selectedDate.value,
      sets: _setsController.qnt,
      reps: _repsController.qnt,
      name: _nameController.text.trim(),
      categoryId: _selectedCategory!.id,
    );

    _setLoading();

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
                  AnimatedBuilder(
                    animation: widget.controller.categories,
                    builder: (_, __) => _dropdownButton(),
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
                controller: _setsController,
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

  Widget _dropdownButton() {
    final items = widget.controller.categories.value.map(
      (it) => DropdownMenuItem(
        value: it,
        child: Text(
          it.name,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );

    return DropdownButtonFormField<Category>(
      items: items.toList(),
      value: _selectedCategory,
      onChanged: (it) => _selectedCategory = it,
      decoration: const InputDecoration(hintText: 'Categoria'),
      validator: (value) {
        if (value == null) return 'Selecione uma categoria';
        return null;
      },
    );
  }

  Widget _submitButton() {
    final isEnabled = _nameController.text.isNotEmpty &&
        _repsController.text.isNotEmpty &&
        _setsController.text.isNotEmpty &&
        _selectedCategory != null;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? _onSubmitButton : null,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromHeight(48),
          backgroundColor: ThemeNotifier.whiteOrBlackColor(),
          foregroundColor: ThemeNotifier.blackOrWhiteColor(),
        ),
        child: Visibility(
          visible: !_isLoading,
          replacement: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              ThemeNotifier.blackOrWhiteColor(),
            ),
          ),
          child: const Text(
            Strings.createExercise,
            style: TextStyle(fontSize: 16),
          ),
        ),
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
