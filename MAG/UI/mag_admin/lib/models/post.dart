import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';

@JsonSerializable()
class Post {
  int? id;
  int? clubId;
  int? userId;
  String? content;
  int? likesCount;
  int? dislikesCount;
  DateTime? datePosted;

  Post(
    this.id,
    this.clubId,
    this.userId,
    this.content,
    this.likesCount,
    this.dislikesCount,
    this.datePosted,
  );

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
