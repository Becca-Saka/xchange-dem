
class UserContact {
  String? uid, contactId;
  String? userName;
  String? displayName, nameInContact;
  String? phoneNumber, countryCode;
  String? imageUrl;
  late int unreadMessageCount;
  late bool isAppUser;

  UserContact(
      {uid,
      contactId,
      userName,
      displayName,
      nameInContact,
      phoneNumber,
      countryCode,
      imageUrl,
      unreadMessageCount = 0,
      isAppUser = false});


  UserContact.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    contactId = json['contactId'];
    userName = json['userName'];
    displayName = json['displayName'];
    nameInContact = json['nameInContact'];
    phoneNumber = json['phoneNumber'];
    countryCode = json['countryCode'];
    imageUrl = json['imageUrl'];
    unreadMessageCount = json['unreadMessageCount'];
    isAppUser = json['isAppUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['uid'] = uid;
    data['contactId'] = contactId;
    data['userName'] = userName;
    data['displayName'] = displayName;
    data['nameInContact'] = nameInContact;
    data['phoneNumber'] = phoneNumber;
    data['countryCode'] = countryCode;
    data['imageUrl'] = imageUrl;
    data['unreadMessageCount'] = unreadMessageCount;
    data['isAppUser'] = isAppUser;
    return data;
  }
}
