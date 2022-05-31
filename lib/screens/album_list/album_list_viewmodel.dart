import 'package:albums_mvvm/repository/album_repository.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../models/album_model.dart';
import '../../networking/albums_service.dart';

class AlbumListViewModel {
  final AlbumRepository _albumRepo;

  AlbumListViewModel({AlbumRepository? albumRepository})
      : _albumRepo = albumRepository ?? AlbumRepository.http();

  Future<List<AlbumModel>> fetchAlbums() async {
    final albums = await _albumRepo.fetchAlbums();

    albums.sort(
      (a, b) {
        return a.title!.toLowerCase().compareTo(b.title!.toLowerCase());
      },
    );

    albums.forEach((element) {
      print('Title for id ${element.id}: ${element.title}');
    });

    return albums;
  }
}
