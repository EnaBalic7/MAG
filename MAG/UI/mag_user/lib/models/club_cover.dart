import 'package:json_annotation/json_annotation.dart';
part 'club_cover.g.dart';

@JsonSerializable()
class ClubCover {
  int? id;
  String? cover;

  ClubCover(
    this.id,
    this.cover,
  );

  factory ClubCover.fromJson(Map<String, dynamic> json) =>
      _$ClubCoverFromJson(json);

  Map<String, dynamic> toJson() => _$ClubCoverToJson(this);
}
