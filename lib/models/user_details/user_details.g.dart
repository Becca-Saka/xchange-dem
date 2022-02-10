// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map json) => UserDetails(
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      imageUrl: json['imageUrl'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      currentDeck: (json['currentDeck'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      currentMatches: (json['currentMatches'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      fcmToken: json['fcmToken'] as String?,
      noOfCurrentMatches: json['noOfCurrentMatches'] as int? ?? 0,
      phoneNumber: json['phoneNumber'] as String?,
      inContact: json['inContact'] as bool? ?? false,
      long: (json['long'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'noOfCurrentMatches': instance.noOfCurrentMatches,
      'imageUrl': instance.imageUrl,
      'fcmToken': instance.fcmToken,
      'lat': instance.lat,
      'long': instance.long,
      'currentMatches': instance.currentMatches,
      'currentDeck': instance.currentDeck,
      'inContact': instance.inContact,
    };
