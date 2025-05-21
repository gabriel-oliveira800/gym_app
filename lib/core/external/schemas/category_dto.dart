import 'package:isar/isar.dart';

import '../../index.dart';
import 'schema_utils.dart';

part 'category_dto.g.dart';

@collection
class CategoryDto {
  Id get isarId => fastHash(id);

  late String id;
  late String name;
  late PhotoDto photo;

  CategoryDto();

  factory CategoryDto.by(Category category) {
    return CategoryDto()
      ..id = category.id
      ..name = category.name
      ..photo = PhotoDto.by(category.photo);
  }
}

@embedded
class PhotoDto {
  late int type;
  late String id;
  late String source;

  PhotoDto();

  factory PhotoDto.by(Photo photo) {
    return PhotoDto()
      ..id = photo.id
      ..source = photo.source
      ..type = switch (photo) {
        NetworkPhoto() => 1,
        _ => 0,
      };
  }
}
