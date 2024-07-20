import 'package:json_annotation/json_annotation.dart';
part 'donation.g.dart';

@JsonSerializable()
class Donation {
  int? id;
  int? userId;
  double? amount;
  DateTime? dateDonated;
  String? transactionId;

  Donation(
      {this.id,
      this.userId,
      this.amount,
      this.dateDonated,
      this.transactionId});

  factory Donation.fromJson(Map<String, dynamic> json) =>
      _$DonationFromJson(json);

  Map<String, dynamic> toJson() => _$DonationToJson(this);
}
