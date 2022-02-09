// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeckDetails _$DeckDetailsFromJson(Map json) => DeckDetails(
      match: (json['match'] as List<dynamic>)
          .map(
              (e) => MatchDetails.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      user: (json['user'] as List<dynamic>)
          .map((e) => UserDetails.fromJson(e as Map))
          .toList(),
    )..isRead = json['isRead'] as bool?;

Map<String, dynamic> _$DeckDetailsToJson(DeckDetails instance) =>
    <String, dynamic>{
      'match': instance.match,
      'user': instance.user,
      'isRead': instance.isRead,
    };
