// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map json) => UserDetails(
      uid: json['uid'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      imageUrl: json['imageUrl'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      currentChatrooms: (json['currentChatrooms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      friendList: (json['friendList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      fcmToken: json['fcmToken'] as String?,
      noOfCurrentMatches: json['noOfCurrentMatches'] as int? ?? 0,
      phoneNumber: json['phoneNumber'] as String?,
      countryCode: json['countryCode'] as String?,
      long: (json['long'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'userName': instance.userName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'countryCode': instance.countryCode,
      'noOfCurrentMatches': instance.noOfCurrentMatches,
      'imageUrl': instance.imageUrl,
      'fcmToken': instance.fcmToken,
      'lat': instance.lat,
      'long': instance.long,
      'friendList': instance.friendList,
      'currentChatrooms': instance.currentChatrooms,
    };
