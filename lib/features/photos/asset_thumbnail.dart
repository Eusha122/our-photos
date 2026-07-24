import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:photo_manager/photo_manager.dart';

/// Loads a device photo/video thumbnail by its platform id.
///
/// Implemented as a real [ImageProvider] so decoded thumbnails live in
/// Flutter's global [PaintingBinding.instance.imageCache]: bounded memory,
/// automatic eviction and reuse when a tile scrolls back into view. The stored
/// `platformId` is the photo_manager asset id, resolved lazily on first decode.
///
/// Used at a small [pixelSize] for grid tiles and a large one for the
/// full-screen viewer.
@immutable
class AssetThumbnailProvider extends ImageProvider<AssetThumbnailProvider> {
  const AssetThumbnailProvider(this.assetId, {this.pixelSize = 320});

  final String assetId;
  final int pixelSize;

  @override
  Future<AssetThumbnailProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<AssetThumbnailProvider>(this);
  }

  @override
  ImageStreamCompleter loadImage(
    AssetThumbnailProvider key,
    ImageDecoderCallback decode,
  ) {
    return OneFrameImageStreamCompleter(
      _loadAsync(key, decode),
      informationCollector: () => [ErrorDescription('Asset id: $assetId')],
    );
  }

  Future<ImageInfo> _loadAsync(
    AssetThumbnailProvider key,
    ImageDecoderCallback decode,
  ) async {
    final entity = await AssetEntity.fromId(assetId);
    if (entity == null) {
      throw StateError('Asset $assetId is no longer available');
    }
    final bytes = await entity.thumbnailDataWithSize(
      ThumbnailSize.square(pixelSize),
      quality: 90,
    );
    if (bytes == null) {
      throw StateError('No thumbnail data for asset $assetId');
    }
    final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    final codec = await decode(buffer);
    final frame = await codec.getNextFrame();
    return ImageInfo(image: frame.image);
  }

  @override
  bool operator ==(Object other) {
    return other is AssetThumbnailProvider &&
        other.assetId == assetId &&
        other.pixelSize == pixelSize;
  }

  @override
  int get hashCode => Object.hash(assetId, pixelSize);
}
