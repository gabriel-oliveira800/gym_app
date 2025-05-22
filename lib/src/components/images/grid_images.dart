import 'package:flutter/material.dart';

import '../../../shared/images.dart';
import '../../../core/index.dart';
import '../index.dart';

class GridImages extends StatelessWidget {
  final Photos gallery;
  final Photo? selectedImage;
  final ValueChanged<Photo> onSelected;

  const GridImages({
    super.key,
    this.selectedImage,
    required this.gallery,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: gallery.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) => ThemeWrapper(
        builder: (_, __) => _imagePreview(gallery[index]),
      ),
    );
  }

  Widget _imagePreview(Photo image) {
    final color = ThemeNotifier.whiteOrBlackColor();
    final isSelected = selectedImage?.id == image.id;

    return GestureDetector(
      onTap: () => onSelected(image),
      child: Container(
        decoration: BoxDecoration(
          border: switch (isSelected) {
            true => Border.all(width: 2, color: color),
            _ => null,
          },
          borderRadius: BorderRadius.circular(14),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: const AssetImage(Images.placeholder),
            imageErrorBuilder: (_, __, ___) => Image.asset(Images.placeholder),
            image: switch (image) {
              AssetPhoto() => AssetImage(image.source),
              NetworkPhoto() => NetworkImage(image.source),
              _ => const AssetImage(Images.photo01),
            },
          ),
        ),
      ),
    );
  }
}
