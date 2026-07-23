class AlbumActions {
  Future<void> createCustomAlbum(String title) async {}

  Future<void> setCover({
    required String albumId,
    required String assetId,
  }) async {}

  Future<void> moveAssets({
    required List<String> assetIds,
    required String albumId,
  }) async {}
}
