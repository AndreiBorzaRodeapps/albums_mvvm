import 'package:albums_mvvm/repository/album_repository.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../models/album_model.dart';
import '../../networking/albums_service.dart';

class AlbumListViewModel {
  final AlbumRepository _albumRepo;
  List<AlbumModel> _albums = [];

  AlbumListViewModel({AlbumRepository? albumRepository})
      : _albumRepo = albumRepository ?? AlbumRepository.http();

  Future<List<AlbumModel>> fetchAlbums() async {
    _albums = await _albumRepo.fetchAlbums();

    _albums.sort(
      (a, b) {
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      },
    );
    return _albums;
  }

  bool showDetails(AlbumModel album) {
    return album.id % 2 == 0 ? true : false;
  }
}
