import '../models/album_model.dart';
import '../networking/albums_service.dart';
import 'package:dio/dio.dart';

class AlbumRepository {
  final AlbumService _albumService;

  AlbumRepository(this._albumService);

  factory AlbumRepository.http() {
    return AlbumRepository(AlbumService(Dio()));
  }

  Future<List<AlbumModel>> fetchAlbums() => _albumService.getAlbums();
}
