import 'package:flutter/material.dart';

import '../../../../shared/states/index.dart';
import '../../../components/index.dart';

import '../../../../shared/index.dart';
import '../../../../core/index.dart';
import '../../home_controller.dart';

import 'add_category_controller.dart';

class AddCategoryContent extends StatefulWidget {
  final HomeController controller;
  const AddCategoryContent({
    super.key,
    required this.controller,
  });

  @override
  State<AddCategoryContent> createState() => _AddCategoryContentState();

  static Future<Category?> show(
    BuildContext context, {
    required HomeController controller,
  }) async {
    return await showModalBottomSheet(
      context: context,
      shape: 16.modalShape(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddCategoryContent(controller: controller),
    );
  }
}

class _AddCategoryContentState extends State<AddCategoryContent> {
  late final AddCategoryController _controller;
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _controller = AddCategoryController();
    _nameController = TextEditingController();
  }

  void _onSubmitButton() async {
    await _controller.create(
      _nameController.text.trim(),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Strings.newCategory,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ThemeNotifier.whiteOrBlackColor(),
                  ),
                ),
                const Spacing.vertical(24),
                _categoryNameInput(),
                const Spacing.vertical(8),
                MultiStateOfBuilder<Photos, Photo?>(
                  states: [
                    _controller.gallery,
                    _controller.selectedImage,
                  ],
                  builder: (gallery, selected) => AddImage(
                    gallery: gallery,
                    selectedImage: selected,
                    onAdd: _controller.updateGallery,
                    onSelected: _controller.selectedImage.update,
                  ),
                ),
                AnimatedBuilder(
                  animation: _nameController,
                  builder: (_, __) => _submitButton(),
                ),
                const Spacing.vertical(24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _categoryNameInput() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(24),
        ),
        hintText: Strings.nameCategory,
      ),
    );
  }

  Widget _submitButton() {
    return Button(
      onPressed: _onSubmitButton,
      text: Strings.createCategory,
      inLoading: _controller.inLoading,
      isEnabled: _nameController.isNotEmpty,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
