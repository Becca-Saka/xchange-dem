import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:xchange/data/models/user_contact.dart';

class LocalDataSource {
  static GetStorage _box() => GetStorage('userContactsBox');
  static final userDetail = ReadWriteValue('userContact', '', _box);

  void writeContactToStorage(List<UserContact> value) {
    final data = value.map((e) => e.toJson()).toList();
    userDetail.val = jsonEncode(data);
  }

  List<UserContact>? readContactFromStorage() {
    final val = userDetail.val;
    if (val.isNotEmpty) {
      final data = jsonDecode(val) as List<dynamic>;
      final listContacts = data
          .map((e) => UserContact.fromJson(e as Map<String, dynamic>))
          .toList();
      return listContacts;
    }
    return null;
  }


  static Future<void> clearBoxes() async => userDetail.val = '';
}
