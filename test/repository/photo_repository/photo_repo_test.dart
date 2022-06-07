import 'package:albums_mvvm/models/photo_model.dart';
import 'package:albums_mvvm/networking/photos_service.dart';
import 'package:albums_mvvm/repository/photo_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'photo_repo_test.mocks.dart';

@GenerateMocks([PhotoService])
void main() {
  test('photo repo test', () async {
    final photoService = MockPhotoService();
    final photoRepo = PhotoRepository(photoService);

    const mockAlbumId = 2;
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
          thumbnailUrl: '')
    ];

    when(photoService.getPhotosForAlbumId(mockAlbumId))
        .thenAnswer((_) async => expectedPhotosList);

    final response = await photoRepo.fetchPhotosForAlbumId(mockAlbumId);

    expect(response, [
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
          thumbnailUrl: '')
    ]);
  });
}
