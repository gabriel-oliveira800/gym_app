import 'photo.dart';

typedef Categories = List<Category>;

class Category {
  final String id;
  final String name;
  final Photo photo;

  const Category({
    required this.id,
    required this.name,
    required this.photo,
  });

  @override
  String toString() {
    return 'Category(id: $id, name: $name, photo: $photo)';
  }
}
