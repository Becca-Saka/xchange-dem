import 'package:json_annotation/json_annotation.dart';

part 'user_details.g.dart';

@JsonSerializable(
  anyMap: true,
)
class UserDetails {
  String? uid;
  String? userName;
  @JsonKey(ignore: true)
  String? nameInContact;
  String? email, phoneNumber, countryCode;
  int noOfCurrentMatches;
  String? imageUrl, fcmToken;
  double? lat, long;
  List<String>? currentMatches;
  List<String>? currentDeck;
  @JsonKey(ignore: true)
  bool inContact;

  UserDetails(
      {this.uid,
      this.userName,
      this.nameInContact,
      this.email,
      this.imageUrl,
      this.lat,
      this.currentDeck,
      this.currentMatches,
      this.fcmToken,
      this.noOfCurrentMatches = 0,
      this.phoneNumber,
      this.countryCode,
      this.inContact = false,
      this.long});

  factory UserDetails.fromJson(Map<dynamic, dynamic> json) =>
      _$UserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);

  @override
  String toString() {
    return 'uid: $uid, name: $userName, lat: $lat, long: $long, currentmatches: $currentMatches';
  }
}
