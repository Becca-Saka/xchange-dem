import 'package:contacts_service/contacts_service.dart';
import 'package:xchange/app/barrel.dart';

import '../helpers/permission_manager.dart';

class ContactService {
  List<Contact>? userContacts;
  List<Map<String, dynamic>> mappedUserContacts = [];

  Future<List<Contact>?> processContactFromPhone() async {
    try {
      if (await PermissionManager.getContactPermission()) {
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
    final contacts = await processContactFromPhone();
    if (contacts != null) {
      contacts.removeWhere((element) => element.phones == null);
      contacts.removeWhere((element) => !GetUtils.isPhoneNumber(
          element.phones![0].value!.removeAllWhitespace));
      userContacts = contacts;

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
    }
    return standardNumbers;
  }

 
}
