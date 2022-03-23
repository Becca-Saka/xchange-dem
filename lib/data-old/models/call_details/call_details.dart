import 'package:json_annotation/json_annotation.dart';
part 'call_details.g.dart'; 

@JsonSerializable(
  anyMap: true,
)
class CallDetails {
  String callerId;
  String callerName;
  String? callerPic;
  String receiverId;
  String receiverName;
  String? receiverPic;
  String channelId;
  bool hasDialled;

  CallDetails({
    required this.callerId,
    required this.callerName,
    this.callerPic,
    required this.receiverId,
    required this.receiverName,
    this.receiverPic,
    required this.channelId,
    this.hasDialled = false,
  });

  factory CallDetails.fromJson(Map<String, dynamic> json) =>
      _$CallDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$CallDetailsToJson(this);
}