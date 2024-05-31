import 'package:json_annotation/json_annotation.dart';
part 'club_user.g.dart';

@JsonSerializable()
class ClubUser {
  int? id;
  int? clubId;
  int? userId;

  ClubUser(
    this.id,
    this.clubId,
    this.userId,
  );

  factory ClubUser.fromJson(Map<String, dynamic> json) =>
      _$ClubUserFromJson(json);

  Map<String, dynamic> toJson() => _$ClubUserToJson(this);
}
