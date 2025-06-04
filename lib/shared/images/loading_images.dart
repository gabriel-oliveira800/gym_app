import 'package:flutter/services.dart';

import '../../core/index.dart';
import '../images.dart';

class LoadingImages {
  LoadingImages._();
  factory LoadingImages() => _instance;
  static final LoadingImages _instance = LoadingImages._();

  final _images = <String, Uint8List>{};

  Future<Uint8List> loading(Photo it) async {
    if (_images.containsKey(it.source)) return _images[it.source]!;

    final bytes = (await rootBundle.load(it.source)).buffer.asUint8List();
    return _images[it.source] = bytes;
  }

  Future<void> loadingAll() async {
    await Future.wait(Images.all.map(loading).toList(growable: false));
  }
}
