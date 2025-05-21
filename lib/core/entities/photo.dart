typedef Photos = List<Photo>;

abstract class Photo {
  final String id;
  final String source;
  const Photo(this.source, {this.id = ''});
}

class AssetPhoto extends Photo {
  const AssetPhoto(super.source, {super.id = ''});
}

class NetworkPhoto extends Photo {
  const NetworkPhoto(super.source) : super(id: 'network-$source');
}
