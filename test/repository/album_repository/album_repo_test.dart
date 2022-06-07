import 'package:albums_mvvm/models/album_model.dart';
import 'package:albums_mvvm/networking/albums_service.dart';
import 'package:albums_mvvm/repository/album_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'album_repo_test.mocks.dart';

@GenerateMocks([AlbumService])
void main() {
  test('albums repo', () async {
    final mockAlbumService = MockAlbumService();
    final albumRepo = AlbumRepository(mockAlbumService);

    final List<AlbumModel> expectedAlbums = [
      AlbumModel(id: 1, userId: 1, title: 'mock1'),
      AlbumModel(id: 2, userId: 1, title: 'mock2')
    ];

    when(mockAlbumService.getAlbums()).thenAnswer((_) async => expectedAlbums);
    final response = await albumRepo.fetchAlbums();

    expect(response, [
      AlbumModel(id: 1, userId: 1, title: 'mock1'),
      AlbumModel(id: 2, userId: 1, title: 'mock2')
    ]);
  });
}
