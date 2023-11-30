import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class QAcategory {
  int? id;
  String? name;

  QAcategory(this.id, this.name);
}
