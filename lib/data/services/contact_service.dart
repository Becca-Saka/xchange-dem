import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:xchange/app/barrel.dart';

class ContactService {
List<Contact>? userContacts;
  List<Map<String, dynamic>> mappedUserContacts = [];
  //get user contact
  Future<PermissionStatus> getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Future<List<Contact>?> _getContactFromPhone() async {
    try {
      if (await getContactPermission() == PermissionStatus.granted) {
        List<Contact> contacts = (await ContactsService.getContacts(
          withThumbnails: false,
        ))
            .toList();
        return contacts;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }


  Future<List<String>> getContactNumbers() async {
    final List<String> standardNumbers = [];
    userContacts = await _getContactFromPhone();
    if (userContacts != null) {
      userContacts!.removeWhere((element) => element.phones == null);
      userContacts!.removeWhere((element) => !GetUtils.isPhoneNumber(
          element.phones![0].value!.removeAllWhitespace));

      // userContacts.removeWhere(
      //     (element) => element.phones![0].value!.s GetUtils.isPhoneNumber(element.phones![0].value!));
      final phoneNumbers = userContacts!.map((e) {
        return e.phones![0].value!.removeAllWhitespace;
      }).toList();

      for (var element in phoneNumbers) {
        final number = await NumberParser.getNumberDetails(element);
        if (number != null) {
          final phoneNumber = number['e164'];
          final name = userContacts!.where((e) {
            final num = e.phones![0].value!.removeAllWhitespace;
            return phoneNumber == num ||
                number['national_number'] == num ||
                number['national'].toString().removeAllWhitespace == num;
          }).toList();
          if (name.isNotEmpty) {
            mappedUserContacts.add({
              'name': name[0].displayName,
              'number': phoneNumber,
            });
          }
          standardNumbers.add(number['e164']);
        }
      }

      log('mapped user contacts: $mappedUserContacts');
    }
    return standardNumbers;
  }
}
