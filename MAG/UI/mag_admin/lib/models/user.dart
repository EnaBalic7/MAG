import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  int? profilePictureId;
  DateTime? dateJoined;

  User(this.id, this.firstName, this.lastName, this.username, this.email,
      this.profilePictureId, this.dateJoined);
}
