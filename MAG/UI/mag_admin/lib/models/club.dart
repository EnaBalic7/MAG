import 'package:json_annotation/json_annotation.dart';
part 'club.g.dart';

@JsonSerializable()
class Club {
  int? id;
  int? ownerId;
  String? name;
  String? description;
  int? memberCount;
  DateTime? dateCreated;

  Club(
    this.id,
    this.ownerId,
    this.name,
    this.description,
    this.memberCount,
    this.dateCreated,
  );

  factory Club.fromJson(Map<String, dynamic> json) => _$ClubFromJson(json);

  Map<String, dynamic> toJson() => _$ClubToJson(this);
}
