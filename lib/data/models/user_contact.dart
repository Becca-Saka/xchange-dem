class UserContact {
  String? uid, contactId;
  String? userName;
  String? displayName, nameInContact;
  String? phoneNumber, countryCode;
  String? imageUrl;
  int unreadMessageCount = 0;

  UserContact(
      {this.uid,
      this.contactId,
      this.userName,
      this.displayName,
      this.nameInContact,
      this.phoneNumber,
      this.countryCode,
      this.imageUrl,
      this.unreadMessageCount =0,});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['contactId'] = contactId;
    data['userName'] = userName;
    data['displayName'] = displayName;
    data['nameInContact'] = nameInContact;
    data['phoneNumber'] = phoneNumber;
    data['countryCode'] = countryCode;
    data['imageUrl'] = imageUrl;
    data['unreadMessageCount'] = unreadMessageCount;
    return data;
  }
}
