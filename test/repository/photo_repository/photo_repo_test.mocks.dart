// Mocks generated by Mockito 5.2.0 from annotations
// in albums_mvvm/test/repository/photo_repository/photo_repo_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:albums_mvvm/models/photo_model.dart' as _i4;
import 'package:albums_mvvm/networking/photos_service.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [PhotoService].
///
/// See the documentation for Mockito's code generation for more information.
class MockPhotoService extends _i1.Mock implements _i2.PhotoService {
  MockPhotoService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.PhotoModel>> getPhotosForAlbumId(int? albumId) =>
      (super.noSuchMethod(Invocation.method(#getPhotosForAlbumId, [albumId]),
              returnValue:
                  Future<List<_i4.PhotoModel>>.value(<_i4.PhotoModel>[]))
          as _i3.Future<List<_i4.PhotoModel>>);
}
