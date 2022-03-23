import 'dart:developer';

import 'package:contacts_service/contacts_service.dart';
import 'package:xchange/app/barrel.dart';
import 'package:xchange/data/models/user_contact.dart';
import 'package:xchange/data/repository/contact_repository.dart';
import 'package:xchange/ui/views/home/home_view.dart';

class ContactListView extends StatefulWidget {
  const ContactListView({Key? key}) : super(key: key);

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  final _contactService = ContactService();
  final _contactRepository = ContactRepository();
  List<Contact> _contacts = [];
  List<UserContact> _userContacts = [];
  @override
  initState() {
    getContacts();
    super.initState();
  }

  getContacts() async {
    final cont = _contactRepository.getUserContactsFromStorage();
    if (cont != null) {
      setState(() {
        _userContacts = cont;
      });
    }
  }
  //   getContacts() async {
  //   final usercontacts = await _contactService.getContactFromPhone();
  //   if (usercontacts != null) {
  //     setState(() {
  //       _contacts = usercontacts;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _userContacts.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  final user = _userContacts[index];
                  return UserListItem(
                    title: '${user.nameInContact}',
                  );
                },
                itemCount: _userContacts.length,
              )
            : const Center(
                child: Text('No Contacts'),
              ),
      ),
    );
  }
}
