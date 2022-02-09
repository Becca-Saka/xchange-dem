import 'package:json_annotation/json_annotation.dart';
import 'package:xchange/barrel.dart';
part 'deck_details.g.dart';

@JsonSerializable(
  anyMap: true,
)
class DeckDetails {
  List<MatchDetails> match;
  List<UserDetails> user;
  bool? isRead = false;
  DeckDetails({required this.match, required this.user});
  factory DeckDetails.fromJson(Map<String, dynamic> json) =>
      _$DeckDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$DeckDetailsToJson(this);
  @override
  String toString() {
    return 'match: $match, user $user';
  }
}
