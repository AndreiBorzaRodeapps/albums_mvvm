import '../models/album_model.dart';
import '../networking/albums_service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AlbumRepository {
  final AlbumService _albumService;
  List<AlbumModel> _albums = [];

  AlbumRepository(this._albumService);

  factory AlbumRepository.http() {
    return AlbumRepository(AlbumService(Dio()));
  }

  Future<List<AlbumModel>> fetchAlbums() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      //save local
      _albums = await _albumService.getAlbums();
      prefs.remove('albums');

      prefs.setStringList('albums', [
        ..._albums.map((album) => json.encode(
            {'id': album.id, 'title': album.title, 'userId': album.userId}))
      ]);
    } catch (error) {
      //retrieve locals
      final List<String>? stringList = prefs.getStringList('albums');
      if (stringList != null) {
        for (var element in stringList) {
          final data = json.decode(element);
          _albums.add(AlbumModel(
              id: data['id'], title: data['title'], userId: data['userId']));
        }
      }
    }

    return _albums;
  }
}
