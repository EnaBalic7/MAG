import 'package:json_annotation/json_annotation.dart';

part 'list.g.dart';

@JsonSerializable()
class List {
  int? id;
  int? userId;
  String? name;
  DateTime? dateCreated;

  List(this.id, this.userId, this.name, this.dateCreated);

  factory List.fromJson(Map<String, dynamic> json) => _$ListFromJson(json);

  Map<String, dynamic> toJson() => _$ListToJson(this);
}
