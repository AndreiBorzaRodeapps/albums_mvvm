import '../../models/photo_model.dart';
import '../../repository/photo_repository.dart';

class PhotoListViewModel {
  final PhotoRepository _photoRepo;
  List<PhotoModel> _photos = [];

  PhotoListViewModel({PhotoRepository? photoRepository})
      : _photoRepo = photoRepository ?? PhotoRepository.http();

  Future<List<PhotoModel>> fetchPhotosForAlbumId(int id) async {
    _photos = [];
    _photos = await _photoRepo.fetchPhotosForAlbumId(id);

    print('[DEBUG] Fetched id: $id');
    
    return _photos;
  }
}
