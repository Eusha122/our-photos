import 'media_status.dart';

class GalleryAsset {
  const GalleryAsset({
    required this.id,
    required this.platformId,
    required this.fileName,
    required this.kind,
    required this.createdAt,
    required this.addedAt,
    required this.width,
    required this.height,
    required this.sizeBytes,
    this.folderName,
    this.cameraMake,
    this.cameraModel,
    this.latitude,
    this.longitude,
    this.placeName,
    this.isFavorite = false,
    this.isHidden = false,
    this.isDeleted = false,
    this.statuses = const {MediaStatus.local},
  });

  final String id;
  final String platformId;
  final String fileName;
  final MediaKind kind;
  final DateTime createdAt;
  final DateTime addedAt;
  final int width;
  final int height;
  final int sizeBytes;
  final String? folderName;
  final String? cameraMake;
  final String? cameraModel;
  final double? latitude;
  final double? longitude;
  final String? placeName;
  final bool isFavorite;
  final bool isHidden;
  final bool isDeleted;
  final Set<MediaStatus> statuses;

  bool get isPortrait => height > width;
  bool get isLandscape => width >= height;
}
