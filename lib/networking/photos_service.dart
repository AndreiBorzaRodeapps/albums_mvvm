import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/photo_model.dart';

part 'photos_service.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class PhotoService {
  factory PhotoService(Dio dio, {String baseUrl}) = _PhotoService;

  @GET("/photos")
  Future<List<PhotoModel>> getPhotosForAlbumId(@Query("albumId") int albumId);
}
