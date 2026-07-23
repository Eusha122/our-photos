import '../../models/gallery_asset.dart';
import '../../repositories/gallery_repository.dart';

class MemoryVaultSearchController {
  MemoryVaultSearchController(this._repository);

  final GalleryRepository _repository;

  Future<List<GalleryAsset>> search(String query) {
    return _repository.searchOffline(query);
  }
}
