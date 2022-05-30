import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import '../models/album_model.dart';
import '../helpers/rest_help.dart';

class Album_ViewModel {
  Future<List<AlbumModel>> fetchAlbums() async {
    final dio = Dio();
    final client = RestClient(dio);
    final albums = await client.getAlbums();
    // print('Len of albs: ' + albums.length.toString());

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
