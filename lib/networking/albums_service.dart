// import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/album_model.dart';

part 'albums_service.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class AlbumService {
  factory AlbumService(Dio dio, {String baseUrl}) = _AlbumService;

  @GET("/albums")
  Future<List<AlbumModel>> getAlbums();


  /*
  @GET("/albums")
  Future<List<Photo>> getPhotosForAlbum(@Query("albumId") int albumId);

  */
}
