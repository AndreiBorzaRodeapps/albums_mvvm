import 'package:albums_mvvm/models/photo_model.dart';
import 'package:albums_mvvm/repository/photo_repository.dart';
import 'package:albums_mvvm/screens/album_details/photo_list_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'photos_viewmodel_test.mocks.dart';

@GenerateMocks([PhotoRepository])
void main() {
  late PhotoRepository mockRepo;
  late PhotoListViewModel photosListVM;

  setUp(() {
    mockRepo = MockPhotoRepository();
    photosListVM = PhotoListViewModel(photoRepository: mockRepo);
  });

  test('photo list vm fetching photos for album id', () async {
    const mockAlbumId = 84;
    final List<PhotoModel> expectedPhotosList = [
      PhotoModel(
          albumId: mockAlbumId,
          id: 1,
          title: 'firstPhoto',
          url: '',
          thumbnailUrl: ''),
      PhotoModel(
          albumId: mockAlbumId,
          id: 2,
          title: 'secondPhoto',
          url: '',
          thumbnailUrl: ''),
      PhotoModel(
          albumId: mockAlbumId,
          id: 3,
          title: 'thirdPhoto',
          url: '',
          thumbnailUrl: '')
    ];

    when(photosListVM.fetchPhotosForAlbumId(mockAlbumId))
        .thenAnswer((_) async => expectedPhotosList);
    final response = await photosListVM.fetchPhotosForAlbumId(mockAlbumId);

    expect({
      'response': response,
      'totalPhotos': response.length
    }, {
      'response': [
        PhotoModel(
            albumId: mockAlbumId,
            id: 1,
            title: 'firstPhoto',
            url: '',
            thumbnailUrl: ''),
        PhotoModel(
            albumId: mockAlbumId,
            id: 2,
            title: 'secondPhoto',
            url: '',
            thumbnailUrl: ''),
        PhotoModel(
            albumId: mockAlbumId,
            id: 3,
            title: 'thirdPhoto',
            url: '',
            thumbnailUrl: '')
      ],
      'totalPhotos': 3
    });
  });
}
