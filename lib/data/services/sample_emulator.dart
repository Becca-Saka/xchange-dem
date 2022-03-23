import 'dart:convert';
import 'dart:developer';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xchange/app/barrel.dart';
import 'package:xchange/data-old/services-old/authentication_service.dart';
import 'package:xchange/ui/shared/number_parser.dart';

import '../../data-old/models/user_details/user_details.dart';

class EmulatorService {
  saveContact(Contact contact) async {
    await ContactsService.addContact(contact);
  }

  deleteContact() async {
    final contacts = await ContactsService.getContacts();
    contacts.forEach((element) async {
      await ContactsService.deleteContact(element);
    });
  }

  void loadContacts() async {
    try {
      // await login();
      // List<UserDetails> valid = [];
      print('object');
      final _rawData = await rootBundle.loadString("assets/json/contact.json");
      final List data = await json.decode(_rawData);
      final dataProc = data;
      final List toRemove = [];
      log('data ${data.length}');
      for (var d in dataProc) {
        final ds = await NumberParser.getNumberDetails(
          d['number'],
        );
        if (ds.isEmpty) {
          toRemove.add(d);
        }
        d['countryCode'] = ds['country_code'];
        // log('ds: ${d['name']} $ds');
      }
      data.removeWhere((element) => toRemove.contains(element));
      log('data done ${data.length}');
      final tahe = data.take(3);
      log('data done tahe ${tahe.length}');

      for (var d in tahe) {
        final contact = Contact();
        contact.displayName = d['name'];
        contact.givenName = d['name'];
        contact.phones = [
          Item(
            label: 'mobile',
            value: d['number'],
          ),
        ];
        await saveContact(contact);

        await authenticateUsers(d['name'], d['number'], d['countryCode']);
      }
      final last = data.last;
      log('data done last ${last}');
    } on PlatformException catch (e) {
      print(e);
    }
  }
}

// String code = '';
// register(numb) {
//   AuthenticationService.to.verifyPhoneNumber(numb,
//       onCodeSent: (String verificationId, {int? token}) {
//     code = verificationId;
//     print('onCodeSent $verificationId $token');
//   }, onError: () {});
// }

authenticateUsers(name, number, countryCode) async {
  try {
    final firestore = FirebaseFirestore.instance;
    final doc = firestore.collection('users').doc();
    final ff = {
      'uid': doc.id,
      'name': name,
      'phoneNumber': number,
      'countryCode': countryCode,
    };
    await firestore.collection("Users").doc().set(ff);
  } on Exception catch (e) {
    log('error: $e');
  }
}

class LoadEmulatorDataView extends StatelessWidget {
  const LoadEmulatorDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emulator'),
      ),
      body: Center(
        child: RaisedButton(
          child: const Text('Load'),
          onPressed: () {
            EmulatorService().deleteContact();
          },
        ),
      ),
    );
  }
}
