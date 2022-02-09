import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactService {
  //get user contact
  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  getContactFromPhone() async {
    if (await _getContactPermission() == PermissionStatus.granted) {
      List<Contact> contacts = (await ContactsService.getContacts(
        withThumbnails: false,
      )).toList();
      return contacts;
    }
  }
}
