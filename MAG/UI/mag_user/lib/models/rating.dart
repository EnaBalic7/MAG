import 'package:json_annotation/json_annotation.dart';
part 'rating.g.dart';

@JsonSerializable()
class Rating {
  int? id;
  int? userId;
  int? animeId;
  int? ratingValue;
  String? reviewText;
  DateTime? dateAdded;

  Rating(
    this.id,
    this.userId,
    this.animeId,
    this.ratingValue,
    this.reviewText,
    this.dateAdded,
  );

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);
}
