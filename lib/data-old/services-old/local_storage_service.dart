import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static GetStorage _box() => GetStorage('userProfile');
  static final userDetail = ReadWriteValue('userDetails', '', _box);
  static final authenticationStarted = ReadWriteValue<bool>('auth', false, _box);
  static final userLoggedIn = ReadWriteValue<bool>('loggedIn', false, _box);

  static Future<void> clearBoxes() async {
    userDetail.val = '';
    authenticationStarted.val = false;
    userLoggedIn.val = false;
  }
}
