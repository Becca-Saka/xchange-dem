import 'dart:developer';

import 'package:contacts_service/contacts_service.dart';
import 'package:xchange/app/barrel.dart';
import 'package:xchange/ui/views/home/home_view.dart';

class ContactListView extends StatefulWidget {
  const ContactListView({Key? key}) : super(key: key);

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  final _contactService = ContactService();
  List<Contact> _contacts = [];
  @override
  initState() {
    getContacts();
    super.initState();
  }

  getContacts() async {
    final usercontacts = await _contactService.getContactFromPhone();
    if (usercontacts != null) {
      setState(() {
        _contacts = usercontacts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _contacts.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  final user = _contacts[index];
                  return UserListItem(
                    title: user.displayName!,
                  );
                },
                itemCount: _contacts.length,
              )
            : const Center(
                child: Text('No Contacts'),
              ),
      ),
    );
  }
}
