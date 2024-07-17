// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Donation _$DonationFromJson(Map<String, dynamic> json) => Donation(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      amount: (json['amount'] as num?)?.toDouble(),
      dateDonated: json['dateDonated'] == null
          ? null
          : DateTime.parse(json['dateDonated'] as String),
      transactionId: json['transactionId'] as String?,
    );

Map<String, dynamic> _$DonationToJson(Donation instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'amount': instance.amount,
      'dateDonated': instance.dateDonated?.toIso8601String(),
      'transactionId': instance.transactionId,
    };
