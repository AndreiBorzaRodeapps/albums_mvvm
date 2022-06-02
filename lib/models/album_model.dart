import 'package:json_annotation/json_annotation.dart';

part 'album_model.g.dart';

@JsonSerializable()
class AlbumModel {
  final int userId;
  final int id;
  final String title;

  AlbumModel({required this.id, required this.userId, required this.title});

  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);

  String getFirstCharacter({bool upperCase = false}) {
    return upperCase == true
        ? this.title[0].toUpperCase()
        : this.title[0].toLowerCase();
  }
}
