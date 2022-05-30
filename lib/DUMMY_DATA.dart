import '../models/album_model.dart';

class DUMMY_DATA {
  List<AlbumModel> _albums = [
    AlbumModel(title: 'first', id: 1, userId: 1),
    AlbumModel(title: 'second', id: 2, userId: 1),
    AlbumModel(title: 'third', id: 3, userId: 151),
    AlbumModel(title: 'fourth', id: 4, userId: 1513),
    AlbumModel(title: 'fifth', id: 5, userId: 65),
    AlbumModel(title: 'sixth', id: 6, userId: 13),
    AlbumModel(title: 'seventh', id: 7, userId: 67),
    AlbumModel(title: 'eighth', id: 8, userId: 43),
  ];

  List<AlbumModel> get albums {
    return [..._albums];
  }
}
