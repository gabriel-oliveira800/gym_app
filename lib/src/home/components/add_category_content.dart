import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../components/index.dart';
import '../../../shared/index.dart';
import '../../../core/index.dart';

class AddCategoryContent extends StatefulWidget {
  const AddCategoryContent({super.key});

  @override
  State<AddCategoryContent> createState() => _AddCategoryContentState();

  static Future<Category?> show(BuildContext context) async {
    return await showModalBottomSheet<Category?>(
      context: context,
      shape: 16.modalShape(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddCategoryContent(),
    );
  }
}

class _AddCategoryContentState extends State<AddCategoryContent> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _imageController;

  Photos _gallery = Images.all;

  Photo? _selectedImage;
  void _onSelected(Photo image) => setState(() => _selectedImage = image);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _imageController = TextEditingController();
  }

  void _updateGallery() {
    if (!_formKey.currentState!.validate()) return;

    final image = NetworkPhoto(_imageController.text.trim());

    setState(() => _gallery = [..._gallery, image]);
    _onSelected(image);

    _imageController.clear();
  }

  void _onSubmitButton() {
    if (!_formKey.currentState!.validate()) return;

    final category = Category(
      id: const Uuid().v4(),
      name: _nameController.text.trim(),
      photo: switch (_selectedImage != null) {
        true => _selectedImage!,
        _ => Images.randomPhoto(),
      },
    );

    Navigator.of(context).pop(category);
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
                  AnimatedBuilder(
                    animation: _imageController,
                    builder: (_, __) => _imageInput(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: GridImages(
                      gallery: _gallery,
                      onSelected: _onSelected,
                      selectedImage: _selectedImage,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _nameController,
                      _imageController,
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

  Widget _imageInput() {
    return TextFormField(
      controller: _imageController,
      validator: Validations.validateUrl,
      onFieldSubmitted: (_) => _updateGallery(),
      decoration: InputDecoration(
        hintText: Strings.urlImage,
        suffixIcon: Visibility(
          visible: _imageController.text.isNotEmpty,
          child: IconButton(
            onPressed: _updateGallery,
            icon: Icon(Icons.search, color: ThemeNotifier.iconColorByMode()),
          ),
        ),
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
          Strings.createCategory,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();

    _nameController.dispose();
    _imageController.dispose();
    super.dispose();
  }
}
