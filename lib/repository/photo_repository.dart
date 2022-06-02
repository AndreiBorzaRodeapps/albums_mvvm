import '../models/photo_model.dart';
import '../networking/photos_service.dart';
import 'package:dio/dio.dart';

class PhotoRepository {
  final PhotoService _photoService;

  PhotoRepository(this._photoService);

  factory PhotoRepository.http() {
    return PhotoRepository(PhotoService(Dio()));
  }

  Future<List<PhotoModel>> fetchPhotosForAlbumId(int id) {
    return _photoService.getPhotosForAlbumId(id);
  }
}
