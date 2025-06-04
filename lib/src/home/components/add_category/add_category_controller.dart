import 'package:flutter/material.dart';
import 'package:gym_app/main.dart';

import '../../../../shared/states/index.dart';

import '../../../../core/index.dart';
import '../../../../shared/index.dart';

class AddCategoryController {
  final inLoading = InLoading();
  final selectedImage = StateOf<Photo?>(null);
  final gallery = ListStateOf<Photo>(Images.all);

  void updateGallery(NetworkPhoto photo) {
    gallery.copy(photo);
    selectedImage.update(photo);
  }

  Future<void> create(
    String name, {
    required ValueChanged<Category?> onCreated,
  }) async {
    inLoading.toggle();

    Category? dto;

    try {
      dto = await repository.createCategory(
        name: name,
        photo: selectedImage.value ?? Images.randomPhoto(),
      );
    } catch (e) {
      Utils.errorToast(e.toString());
    } finally {
      inLoading.toggle();
      onCreated.call(dto);
    }
  }

  void dispose() {
    gallery.dispose();
    selectedImage.dispose();
  }
}
