import 'dart:math';

import '../core/index.dart';

abstract interface class Images {
  static const _root = 'assets/images';

  static const String placeholder = '$_root/placeholder-image.png';

  static const String photo01 = '$_root/photo-01.jpg';
  static const String photo02 = '$_root/photo-02.jpg';
  static const String photo03 = '$_root/photo-03.jpg';
  static const String photo04 = '$_root/photo-04.jpg';
  static const String photo05 = '$_root/photo-05.jpg';
  static const String photo06 = '$_root/photo-06.jpg';
  static const String photo07 = '$_root/photo-07.jpg';
  static const String photo08 = '$_root/photo-08.jpg';

  static const Photos all = [
    AssetPhoto(photo01, id: 'photo-01'),
    AssetPhoto(photo02, id: 'photo-02'),
    AssetPhoto(photo03, id: 'photo-03'),
    AssetPhoto(photo04, id: 'photo-04'),
    AssetPhoto(photo05, id: 'photo-05'),
    AssetPhoto(photo06, id: 'photo-06'),
    AssetPhoto(photo07, id: 'photo-07'),
    AssetPhoto(photo08, id: 'photo-08'),
  ];

  static Photo randomPhoto() => all[Random().nextInt(all.length)];
}
