import 'package:flutter/material.dart';

import '../../../shared/states/index.dart';
import '../../../shared/index.dart';
import '../../../core/index.dart';
import '../index.dart';

class AddImage extends StatefulWidget {
  final Photos gallery;
  final Photo? selectedImage;
  final ValueChanged<Photo> onSelected;
  final ValueChanged<NetworkPhoto> onAdd;

  const AddImage({
    super.key,
    this.selectedImage,
    required this.onAdd,
    required this.gallery,
    required this.onSelected,
  });

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  final _isExpanded = BoolState(false);
  late final TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    _imageController = TextEditingController();
  }

  void _updateGallery() {
    final text = _imageController.text.trim();
    if (text.isEmpty) return;
    _isExpanded.toggle();

    widget.onAdd(NetworkPhoto(text));
    _imageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: StateOfBuilder(
        state: _isExpanded,
        builder: (isExpanded) => Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GridImages(
                    gallery: widget.gallery,
                    onSelected: widget.onSelected,
                    selectedImage: widget.selectedImage,
                  ),
                ),
                const Spacing.horizontal(8),
                StateOfBuilder(
                  state: _isExpanded,
                  builder: _addButton,
                ),
              ],
            ),
            AnimatedSwitcher(
              duration: 300.duration,
              child: isExpanded ? _urlInput() : const SizedBox.square(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addButton(bool isExpanded) {
    return IconButton(
      onPressed: _isExpanded.toggle,
      icon: Icon(
        isExpanded ? Icons.close : Icons.add,
        color: ThemeNotifier.whiteOrBlackColor(),
      ),
    );
  }

  Widget _urlInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        controller: _imageController,
        validator: Validations.validateUrl,
        onFieldSubmitted: (_) => _updateGallery(),
        decoration: InputDecoration(
          hintText: Strings.urlImage,
          suffixIcon: _suffixIcon(),
        ),
      ),
    );
  }

  Widget _suffixIcon() {
    return AnimatedBuilder(
      animation: _imageController,
      builder: (_, __) => Visibility(
        visible: _imageController.isNotEmpty,
        child: IconButton(
          onPressed: _updateGallery,
          icon: Icon(Icons.search, color: ThemeNotifier.iconColorByMode()),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isExpanded.dispose();
    _imageController.dispose();
    super.dispose();
  }
}
