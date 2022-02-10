import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static GetStorage _box() => GetStorage('userProfile');
  static final userDetail = ReadWriteValue('userDetails', '', _box);

  static Future<void> clearBoxes() async {
    userDetail.val = '';
  }
}
