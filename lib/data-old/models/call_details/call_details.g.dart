// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallDetails _$CallDetailsFromJson(Map json) => CallDetails(
      callerId: json['callerId'] as String,
      callerName: json['callerName'] as String,
      callerPic: json['callerPic'] as String?,
      receiverId: json['receiverId'] as String,
      receiverName: json['receiverName'] as String,
      receiverPic: json['receiverPic'] as String?,
      channelId: json['channelId'] as String,
      hasDialled: json['hasDialled'] as bool? ?? false,
    );

Map<String, dynamic> _$CallDetailsToJson(CallDetails instance) =>
    <String, dynamic>{
      'callerId': instance.callerId,
      'callerName': instance.callerName,
      'callerPic': instance.callerPic,
      'receiverId': instance.receiverId,
      'receiverName': instance.receiverName,
      'receiverPic': instance.receiverPic,
      'channelId': instance.channelId,
      'hasDialled': instance.hasDialled,
    };
