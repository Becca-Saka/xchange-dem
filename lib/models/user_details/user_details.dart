import 'package:json_annotation/json_annotation.dart';
part 'user_details.g.dart';

@JsonSerializable(
  anyMap: true,
)
class UserDetails {
  String? uid;
  String? name;
  String? email,phoneNumber;
  int noOfCurrentMatches;
  String? imageUrl, fcmToken;
  double? lat, long;
  List<String>? currentMatches;
  List<String>? currentDeck;
  bool inContact;
  UserDetails(
      {this.uid,
      this.name,
      this.email,
      this.imageUrl,
      this.lat,
      this.currentDeck,
      this.currentMatches,
      this.fcmToken,
      this.noOfCurrentMatches = 0,
      this.phoneNumber,
      this.inContact = false,
      this.long});
  factory UserDetails.fromJson(Map<dynamic, dynamic> json) =>
      _$UserDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
  @override
  String toString() {
    return 'uid: $uid, name: $name, lat: $lat, long: $long, currentmatches: $currentMatches';
  }
}
