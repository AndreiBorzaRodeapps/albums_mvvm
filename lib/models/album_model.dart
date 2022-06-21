import 'package:json_annotation/json_annotation.dart';

part 'album_model.g.dart';

@JsonSerializable()
class AlbumModel {
  final int userId;
  final int id;
  final String title;

  AlbumModel({
    required this.id,
    required this.userId,
    required this.title,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);

  String getFirstCharacter({bool upperCase = false}) {
    if (title.isNotEmpty) {
      return upperCase == true
          ? title[0].toUpperCase()
          : title[0].toLowerCase();
    }
    return '';
  }

  @override
  bool operator ==(Object other) {
    return other is AlbumModel &&
        other.id == id &&
        other.userId == userId &&
        other.title == title;
  }

  @override
  int get hashCode => id + userId;

}
