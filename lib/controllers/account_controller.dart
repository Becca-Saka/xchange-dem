import 'dart:convert';
import 'dart:developer';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:xchange/barrel.dart';

class AccountController extends GetxController {
  final AuthenticationService _authenticationService = AuthenticationService();
  Rx<UserDetails> userDetails = Rx<UserDetails>(UserDetails());
  RxList<UserDetails> usersInChat = <UserDetails>[].obs;
  List<Contact>? userContact;
  UserDetails currentChat = UserDetails();
  final ContactService _contactService = ContactService();
  final FirestoreService _firestoreService = FirestoreService();
  @override
  void onInit() {
    final userFromStorage = jsonDecode(LocalStorage.userDetail.val);
    userDetails.value =
        UserDetails.fromJson(userFromStorage as Map<String, dynamic>);
    // getUsersInDatabase();
    getRegisteredUserContacts();
    super.onInit();
  }

  getUsersInDatabase() async {
    final data = await FirebaseFirestore.instance.collection('Users').get();
    if (data.docs.isNotEmpty) {
      usersInChat.value =
          data.docs.map((e) => UserDetails.fromJson(e.data())).toList();
      usersInChat
          .removeWhere((element) => element.uid == userDetails.value.uid);
    }
  }

  navigateToChat(UserDetails user) {
    currentChat = user;
    Get.toNamed(Routes.CHAT,
        arguments: {'match': MatchDetails(users: [], isNew: {}, uid: '')});
  }

  logout() async {
    await _authenticationService.logout();
  }

  Future<void> getRegisteredUserContacts() async {
    final phoneNumbers = await _contactService.getContactNumbers();
    final result = await _firestoreService.checkUsersInDataBase(phoneNumbers);
    result.map((e) {
      e.nameInContact = getUserContactName(e.phoneNumber!);
    }).toList();
    usersInChat.value = [...usersInChat, ...result];
    // log('result: $result');
  }

  String getUserContactName(String phoneNumber) {
    if (_contactService.userContacts != null) {
      final contactName = _contactService.mappedUserContacts
          .where((element) => phoneNumber == element['number'])
          .toList();
      if (contactName.isNotEmpty) {
        return contactName.first['name'];
      }
      return phoneNumber;
    } else {
      return phoneNumber;
    }
  }
}
