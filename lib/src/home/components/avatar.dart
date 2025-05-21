import 'package:flutter/material.dart';

import '../../../core/index.dart';
import '../../components/index.dart';

class Avatar extends StatefulWidget {
  final String imageUrl;
  const Avatar({super.key, required this.imageUrl});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _setError(widget.imageUrl.isEmpty);
  }

  void _setError(bool value) => setState(() => _hasError = value);

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (mode, _) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: ThemeNotifier.whiteOrBlackColor(),
            width: 2,
          ),
        ),
        child: CircleAvatar(
          backgroundColor: ThemeNotifier.whiteOrBlackColor(),
          onBackgroundImageError: (_, __) => _setError(true),
          backgroundImage: _hasError ? null : NetworkImage(widget.imageUrl),
          child: switch (_hasError) {
            false => null,
            _ => Icon(Icons.person, color: ThemeNotifier.blackOrWhiteColor())
          },
        ),
      ),
    );
  }
}

class CategoryAvatar extends StatelessWidget {
  final Size size;
  final Photo photo;

  const CategoryAvatar({
    super.key,
    required this.photo,
    this.size = const Size.square(84),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: switch (photo) {
        AssetPhoto() => Image.asset(
            photo.source,
            fit: BoxFit.cover,
            width: size.width,
            height: size.height,
            errorBuilder: (_, __, ___) => const Icon(Icons.error),
          ),
        NetworkPhoto() => Image.network(
            photo.source,
            fit: BoxFit.cover,
            width: size.width,
            height: size.height,
            errorBuilder: (_, __, ___) => const Icon(Icons.error),
          ),
        _ => const SizedBox(),
      },
    );
  }
}
