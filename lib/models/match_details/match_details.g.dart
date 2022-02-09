// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchDetails _$MatchDetailsFromJson(Map json) => MatchDetails(
      uid: json['uid'] as String,
      isNew: Map<String, bool>.from(json['isNew'] as Map),
      messageId: json['messageId'] as String?,
      timeMatched: json['timeMatched'],
      users: (json['users'] as List<dynamic>).map((e) => e as String).toList(),
      recentMessageTime: json['recentMessageTime'],
      unReadMessagesList: (json['unReadMessagesList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      recentmessage: json['recentmessage'] as String?,
    );

Map<String, dynamic> _$MatchDetailsToJson(MatchDetails instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'users': instance.users,
      'isNew': instance.isNew,
      'messageId': instance.messageId,
      'timeMatched': instance.timeMatched,
      'unReadMessagesList': instance.unReadMessagesList,
      'recentmessage': instance.recentmessage,
      'recentMessageTime': instance.recentMessageTime,
    };
