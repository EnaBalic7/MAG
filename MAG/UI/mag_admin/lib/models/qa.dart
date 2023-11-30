import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class QA {
  int? id;
  int? userId;
  int? categoryId;
  String? question;
  String? answer;
  bool? displayed;

  QA(this.id, this.userId, this.categoryId, this.question, this.answer,
      this.displayed);
}
