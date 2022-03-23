import 'dart:developer';

import 'package:contacts_service/contacts_service.dart';
import 'package:xchange/data-old/models/user_details/user_details.dart';
import 'package:xchange/data-old/services-old/firestore_service.dart';
import 'package:xchange/data/models/user_contact.dart';
import 'package:xchange/data/repository/local_storage.dart';
import 'package:xchange/data/services/contact_services.dart';
import 'package:xchange/ui/shared/number_parser.dart';

class ContactRepository {
  final ContactService _contactService = ContactService();
  final LocalDataSource _localDataSource = LocalDataSource();
  final FirestoreService _firestoreService = FirestoreService();

  Future<List<UserDetails>?> _getRegisteredUserContacts() async {
    final phoneNumbers = await _contactService.getContactNumbers();
    if (phoneNumbers.isNotEmpty) {
      final result = await _firestoreService.checkUsersInDataBase(phoneNumbers);
      return result;
    }
    return null;
  }

  Future<void> loadContacts() async {
    final List<Contact>? contacts =
        await _contactService.processContactFromPhone();
    if (contacts != null) {
      final result = await _getRegisteredUserContacts();
      if (result != null) {
        List<UserContact> userContacts = [];

        for (var element in result) {
          Contact cont = Contact();
          for (var e in contacts) {
            final s = await NumberParser.getNumberDetails(e.phones![0].value!);
            if (element.phoneNumber == s['e164']) {
              cont = e;
              break;
            }
          }
          final userContact = UserContact(
              uid: element.uid,
              contactId: cont.identifier,
              userName: element.userName,
              displayName: element.nameInContact,
              nameInContact: cont.displayName,
              countryCode: element.countryCode,
              phoneNumber: element.phoneNumber,
              unreadMessageCount: 0,
              imageUrl: element.imageUrl);
          userContacts.add(userContact);
        }

        _localDataSource.writeContactToStorage(userContacts);
      }
    }
  }

  List<UserContact>? getUserContactsFromStorage() {
    final userContacts = _localDataSource.readContactFromStorage();
    return userContacts;
  }
}
