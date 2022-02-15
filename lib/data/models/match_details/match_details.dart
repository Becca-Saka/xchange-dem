import 'package:json_annotation/json_annotation.dart';
import 'package:xchange/data/models/message_details/message_details.dart';
part 'match_details.g.dart';

@JsonSerializable(
  anyMap: true,
)
class MatchDetails {
  String? uid;
  List<String>? users;
  Map<String, bool>? isNew;
  String? messageId;
  var timeMatched;
  List<String>? unReadMessagesList;
  String? recentmessage;
  var recentMessageTime;
  @JsonKey(ignore: true)
  List<Message>? messages;
  MatchDetails(
      { this.uid,
       this.isNew,
      this.messageId,
      this.timeMatched,
       this.users,
      this.messages,
      this.recentMessageTime,
      this.unReadMessagesList,
      this.recentmessage});
  factory MatchDetails.fromJson(Map<String, dynamic> json) =>
      _$MatchDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$MatchDetailsToJson(this);
  @override
  String toString() {
    return 'uid: $uid';
  }
}
