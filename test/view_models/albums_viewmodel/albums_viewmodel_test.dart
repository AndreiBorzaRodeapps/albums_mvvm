import 'package:albums_mvvm/models/album_model.dart';
import 'package:albums_mvvm/repository/album_repository.dart';
import 'package:albums_mvvm/screens/album_list/album_list_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'albums_viewmodel_test.mocks.dart';

@GenerateMocks([AlbumRepository])
void main() {
  late MockAlbumRepository mockRepo;
  late AlbumListViewModel albumsListVM;

  setUp(() {
    mockRepo = MockAlbumRepository();
    albumsListVM = AlbumListViewModel(albumRepository: mockRepo);
  });

  test('albums view model test fetching albums', () async {
    final List<AlbumModel> expectedAlbums = [
      AlbumModel(id: 1, userId: 1, title: 'mock1'),
      AlbumModel(id: 2, userId: 1, title: 'mock2'),
      AlbumModel(id: 3, userId: 1, title: 'mock3')
    ];

    when(mockRepo.fetchAlbums()).thenAnswer((_) async => expectedAlbums);
    final response = await albumsListVM.fetchAlbums();

    expect(response, [
      AlbumModel(id: 1, userId: 1, title: 'mock1'),
      AlbumModel(id: 2, userId: 1, title: 'mock2'),
      AlbumModel(id: 3, userId: 1, title: 'mock3')
    ]);
  });

  test('albums view model displaying details test', () {
    final mockAlbum1 = AlbumModel(id: 23, userId: 1, title: 'mock1');
    final mockAlbum2 = AlbumModel(id: 58, userId: 14, title: 'mock2');

    final response1 = albumsListVM.showDetails(mockAlbum1);
    final response2 = albumsListVM.showDetails(mockAlbum2);

    expect([response1, response2], [false, true]);
  });
}
