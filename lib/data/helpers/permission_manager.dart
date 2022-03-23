import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static Future<bool> getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      permission = await Permission.contacts.request();
    }
    return permission == PermissionStatus.granted;
  }
}
