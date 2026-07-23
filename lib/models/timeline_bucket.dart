import 'gallery_asset.dart';

class TimelineBucket {
  const TimelineBucket({
    required this.title,
    required this.assets,
    required this.start,
    required this.end,
  });

  final String title;
  final List<GalleryAsset> assets;
  final DateTime start;
  final DateTime end;
}
