import 'package:json_annotation/json_annotation.dart';

import 'club_cover.dart';
part 'club.g.dart';

@JsonSerializable()
class Club {
  int? id;
  int? ownerId;
  String? name;
  String? description;
  int? memberCount;
  DateTime? dateCreated;
  int? coverId;
  ClubCover? cover;

  Club(
    this.id,
    this.ownerId,
    this.name,
    this.description,
    this.memberCount,
    this.dateCreated,
    this.coverId,
    this.cover,
  );

  factory Club.fromJson(Map<String, dynamic> json) => _$ClubFromJson(json);

  Map<String, dynamic> toJson() => _$ClubToJson(this);
}
